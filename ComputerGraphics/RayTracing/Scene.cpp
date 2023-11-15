//
// Created by Göksu Güvendiren on 2019-05-14.
//

#include "Scene.hpp"


void Scene::buildBVH() {
    printf(" - Generating BVH...\n\n");
    this->bvh = new BVHAccel(objects, 1, BVHAccel::SplitMethod::NAIVE);
}

Intersection Scene::intersect(const Ray &ray) const
{
    // TODO Use BVH.cpp's Intersect function instead of the current traversal method
	Intersection dmin, tmp;
	for (auto i : objects) {
		tmp = i->getIntersection(ray);
		dmin = dmin.distance > tmp.distance ? tmp : dmin;
	}
	return dmin;
}

void Scene::sampleLight(Intersection &pos, float &pdf) const
{
    float emit_area_sum = 0;
    for (uint32_t k = 0; k < objects.size(); ++k) {
        if (objects[k]->hasEmit()){
            emit_area_sum += objects[k]->getArea();
        }
    }
    float p = get_random_float() * emit_area_sum;
    emit_area_sum = 0;
    for (uint32_t k = 0; k < objects.size(); ++k) {
        if (objects[k]->hasEmit()){
            emit_area_sum += objects[k]->getArea();
            if (p <= emit_area_sum){
                objects[k]->Sample(pos, pdf);
                break;
            }
        }
    }
}

bool Scene::trace(
        const Ray &ray,
        const std::vector<Object*> &objects,
        float &tNear, uint32_t &index, Object **hitObject)
{
    *hitObject = nullptr;
    for (uint32_t k = 0; k < objects.size(); ++k) {
        float tNearK = kInfinity;
        uint32_t indexK;
        Vector2f uvK;
        if (objects[k]->intersect(ray, tNearK, indexK) && tNearK < tNear) {
            *hitObject = objects[k];
            tNear = tNearK;
            index = indexK;
        }
    }


    return (*hitObject != nullptr);
}

// Implementation of Path Tracing
Vector3f Scene::castRay(const Ray &ray, int depth) const {
    // TODO Implement Path Tracing Algorithm here
    Intersection inter = bvh->Intersect(ray);
    /** 1. If ray hit nothing , return black **/
    if (!inter.happened) {
        return Vector3f(0.0f);
    }
    /** 2. If ray hit light , return emission **/
    if (inter.m->hasEmission()) {
        return inter.m->getEmission();
    }
    /** 3. If ray hit other object , shade (p , wo) **/
    Vector3f L_dir(0.0f), L_indir(0.0f);
    Vector3f p = inter.coords;
    Vector3f wo = normalize(ray.direction); // 物体指向场景
    Vector3f N = inter.normal.normalized();
    /** direct lighting **/
    float pdf_light = 0.0f;
    Intersection inter_light;
    // sampleLight (inter , pdf_light)
    sampleLight(inter_light, pdf_light);
    // Get x , ws , N , emit from inter
    Vector3f x = inter_light.coords;
    Vector3f ws = (x - p).normalized();  // p -> x
    Vector3f NN = inter_light.normal.normalized();
    Vector3f emit = inter_light.emit;
    // Shoot a ray from p to x
    Ray ray_p2x(p, ws);
    Intersection inter_p2x = bvh->Intersect(ray_p2x);
    // If the ray is not blocked in the middle
    if (inter_p2x.happened && inter_p2x.obj->hasEmit()) {
//    if ((intersect(Ray(p, ws)).coords - x).norm() < 0.01) {
        // L_dir = emit * eval (wo , ws , N) * dot (ws , N) * dot (ws, N) / | x-p |^2 / pdf_light
        L_dir = emit * inter.m->eval(wo, ws, N) * dotProduct(ws, N) * dotProduct(-ws, NN) / (x - p).norm() /
                (x - p).norm() / pdf_light;
        // 前两个ws都是指初始射线的出射方向，最后一个ws是光源处的入射方向。光源处的ws是指向光源的，计算时需要反向，不然计算出来的数值是负数，并导致渲染结果一片漆黑。
    }
    /** indirect lighting **/
    // Test Russian Roulette with probability RussianRoulette
    float ksi = get_random_float();
    if (ksi < RussianRoulette) {
        // wi = sample (wo , N)
        Vector3f wi = inter.m->sample(wo, N).normalized();
        // Trace a ray r(p , wi)
        Ray ray_p2wi(p, wi);
        Intersection inter_p2wi = bvh->Intersect(ray_p2wi);
        // If ray r hit a non-emitting object at q
        if (inter_p2wi.happened && !inter_p2wi.obj->hasEmit()) {
            // L_indir = shade (q , wi) * eval (wo , wi , N) * dot (wi , N) / pdf (wo , wi , N) / RussianRoulette
            L_indir = castRay(ray_p2wi, depth) * inter.m->eval(wo, wi, N) * dotProduct(wi, N) /
                      inter.m->pdf(wo, wi, N) / RussianRoulette;
        }
    }
    return L_dir + L_indir;
}


//shade (p , wo)
//    sampleLight (inter , pdf_light)
//          -->> 一个交点 inter 和一个概率密度函数值 pdf_light 作为参数，用于从光源中采样光线并计算对该交点的光照贡献
//    Get x , ws , NN , emit from inter

//    Shoot a ray from p to x

// direct lighting
//    If the ray is not blocked in the middle
//    L_dir = emit * eval (wo , ws , N) * dot (ws , N) * dot (ws, NN) / |x-p |^2 / pdf_light

// indirect lighting
//    L_indir = 0.0
//    Test Russian Roulette with probability RussianRoulette
//    wi = sample (wo , N)
//    Trace a ray r(p , wi)
//    If ray r hit a non-emitting object at q
//    L_indir = shade (q , wi) * eval (wo , wi , N) * dot (wi , N) / pdf (wo , wi , N) / RussianRoulette
//    Return L_dir + L_indir


// https://zhuanlan.zhihu.com/p/370162390
// https://blog.csdn.net/qq_41835314/article/details/125166417