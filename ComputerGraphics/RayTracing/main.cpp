#include "Renderer.hpp"
#include "Scene.hpp"
#include "Triangle.hpp"
#include "Sphere.hpp"
#include "Vector.hpp"
#include "global.hpp"
#include <chrono>

// In the main function of the program, we create the scene (create objects and
// lights) as well as set the options for the render (image width and height,
// maximum recursion depth, field-of-view, etc.). We then call the render
// function().
int main(int argc, char **argv) {

    // Change the definition here to change resolution
    Scene scene(784, 784);

    Material *red = new Material(DIFFUSE, Vector3f(0.0f));
    red->Kd = Vector3f(0.63f, 0.065f, 0.05f);
    Material *green = new Material(DIFFUSE, Vector3f(0.0f));
    green->Kd = Vector3f(0.14f, 0.45f, 0.091f);
    Material *white = new Material(DIFFUSE, Vector3f(0.0f));
    white->Kd = Vector3f(0.725f, 0.71f, 0.68f);
    Material *light = new Material(DIFFUSE, (8.0f * Vector3f(0.747f + 0.058f, 0.747f + 0.258f, 0.747f) +
                                             15.6f * Vector3f(0.740f + 0.287f, 0.740f + 0.160f, 0.740f) +
                                             18.4f * Vector3f(0.737f + 0.642f, 0.737f + 0.159f, 0.737f)));
    light->Kd = Vector3f(0.65f);

    MeshTriangle floor("../models/cornellbox/floor.obj", white);
    MeshTriangle shortbox("../models/cornellbox/shortbox.obj", white);
    MeshTriangle tallbox("../models/cornellbox/tallbox.obj", white);
    MeshTriangle left("../models/cornellbox/left.obj", red);
    MeshTriangle right("../models/cornellbox/right.obj", green);
    MeshTriangle light_("../models/cornellbox/light.obj", light);

    // add objects
    scene.Add(&floor);
    scene.Add(&shortbox);
    scene.Add(&tallbox);
    scene.Add(&left);
    scene.Add(&right);
    scene.Add(&light_);

    // TODO
    scene.buildBVH();

    Renderer r;

    auto start = std::chrono::system_clock::now();
    r.Render(scene);
    auto stop = std::chrono::system_clock::now();

    std::cout << "Render complete: \n";
    std::cout << "Time taken: " << std::chrono::duration_cast<std::chrono::hours>(stop - start).count() << " hours\n";
    std::cout << "          : " << std::chrono::duration_cast<std::chrono::minutes>(stop - start).count()
              << " minutes\n";
    std::cout << "          : " << std::chrono::duration_cast<std::chrono::seconds>(stop - start).count()
              << " seconds\n";

    return 0;
}
/*
• global.hpp：包含了整个框架中会使用的基本函数和变量。
• Vector.hpp: 由于我们不再使用 Eigen 库，因此我们在此处提供了常见的向量操作，例如：dotProduct，crossProduct，normalize。
• Object.hpp: 渲染物体的父类。Triangle 和 Sphere 类都是从该类继承的。
• Scene.hpp: 定义要渲染的场景。包括设置参数，物体以及灯光。
• Renderer.hpp: 渲染器类，它实现了所有光线追踪的操作。
• Material.hpp: 我们从将材质参数拆分到了一个单独的类中，现在每个物体实例都可以拥有自己的材质。
• Intersection.hpp: 这个数据结构包含了相交相关的信息。
• Ray.hpp: 光线类，包含一条光的源头、方向、传递时间 t 和范围 range. • Bounds3.hpp: 包围盒类，
    每个包围盒可由 pMin 和 pMax 两点描述（请思考为什么）。Bounds3::Union 函数的作用是将两个包围盒并成更大的包围盒。
    与材质一样，场景中的每个物体实例都有自己的包围盒。
• BVH.hpp: BVH 加速类。场景 scene 拥有一个 BVHAccel 实例。从根节点开始，我们可以递归地从物体列表构造场景的 BVH.
*/