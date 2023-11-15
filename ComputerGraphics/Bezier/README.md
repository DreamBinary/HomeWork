1. #### result

   green line

   <img src="\img\green.png"/>

   red line

   <img src="\img\red.png"/>

   yellow line

   <img src="\img\yellow.png"/>

   anti compare

   <img src="\img\no_anti.png" width="30%"/><img src="\img\anti.png" width="30%"/>  

2. #### code

imply de Casteljau's algorithm via recursive 

```c++
cv::Point2f recursive_bezier(const std::vector<cv::Point2f> &control_points, float t) {
    // TODO: Implement de Casteljau's algorithm
    if (control_points.size() == 1) {
        return control_points[0];
    }
    std::vector<cv::Point2f> new_control_points;
    for (int i = 0; i < control_points.size() - 1; ++i) {
        auto point = (1 - t) * control_points[i] + t * control_points[i + 1];
        new_control_points.push_back(point);
    }
    return recursive_bezier(new_control_points, t);
}
```

draw bezier curve

```c++
void bezier(const std::vector<cv::Point2f> &control_points, cv::Mat &window) {
    // TODO: Iterate through all t = 0 to t = 1 with small steps, and call de Casteljau's
    // recursive Bezier algorithm.
    for (double t = 0.0; t <= 1.0; t += 0.001) {
        auto point = recursive_bezier(control_points, t);
        window.at<cv::Vec3b>(point.y, point.x)[1] = 255;
    }
}
```

add antialiasing

use the four nearest points

```c++
void bezier(const std::vector<cv::Point2f> &control_points, cv::Mat &window) {
    for (double t = 0.0; t <= 1.0; t += 0.001) {
        cv::Point2f p = recursive_bezier(control_points, t);

        // the four nearest points to point P
        cv::Point2i p0(p.x - std::floor(p.x) < 0.5 ? std::floor(p.x) : std::ceil(p.x),
                       p.y - std::floor(p.y) < 0.5 ? std::floor(p.y) : std::ceil(p.y));
        std::vector<cv::Point2i> ps = {p0, cv::Point2i(p0.x - 1, p0.y),
                                       cv::Point2i(p0.x, p0.y - 1), cv::Point2i(p0.x - 1, p0.y - 1),
        };


        // compute the distance between point P and four center points
        float sum_d = 0.f;
        std::vector<float> ds = {};
        for (int i = 0; i < 4; i++) {
            cv::Point2f cp(ps[i].x + 0.5f, ps[i].y + 0.5f);
            float d = std::sqrt(std::pow(p.x - cp.x, 2) + std::pow(p.y - cp.y, 2));
            ds.push_back(d);
            sum_d += d;
        }

        // assign colors by distance
        for (int i = 0; i < 4; i++) {
            float k = ds[i] / sum_d;
            window.at<cv::Vec3b>(ps[i].y, ps[i].x)[1] = std::min(255.f,
        };
    }
}
```