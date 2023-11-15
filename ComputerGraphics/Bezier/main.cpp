#include <chrono>
#include <iostream>
#include <opencv2/opencv.hpp>

std::vector<cv::Point2f> control_points;

void mouse_handler(int event, int x, int y, int flags, void *userdata) {
    if (event == cv::EVENT_LBUTTONDOWN) {
        std::cout << "Left button of the mouse is clicked - position (" << x << ", "
                  << y << ")" << '\n';
        control_points.emplace_back(x, y);
    }
}

void naive_bezier(const std::vector<cv::Point2f> &points, cv::Mat &window) {
    auto &p_0 = points[0];
    auto &p_1 = points[1];
    auto &p_2 = points[2];
    auto &p_3 = points[3];

    for (double t = 0.0; t <= 1.0; t += 0.001) {
        auto point = std::pow(1 - t, 3) * p_0 + 3 * t * std::pow(1 - t, 2) * p_1 +
                     3 * std::pow(t, 2) * (1 - t) * p_2 + std::pow(t, 3) * p_3;

        window.at<cv::Vec3b>(point.y, point.x)[2] = 255;
    }
}

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

void bezier(const std::vector<cv::Point2f> &control_points, cv::Mat &window) {
    // TODO: Iterate through all t = 0 to t = 1 with small steps, and call de Casteljau's
    // recursive Bezier algorithm.
    for (double t = 0.0; t <= 1.0; t += 0.001) {
        auto point = recursive_bezier(control_points, t);
        window.at<cv::Vec3b>(point.y, point.x)[1] = 255;
    }
}

//void bezier(const std::vector<cv::Point2f> &control_points, cv::Mat &window) {
//    for (double t = 0.0; t <= 1.0; t += 0.001) {
//        cv::Point2f p = recursive_bezier(control_points, t);
//
//        // the four nearest points to point P
//        cv::Point2i p0(p.x - std::floor(p.x) < 0.5 ? std::floor(p.x) : std::ceil(p.x),
//                       p.y - std::floor(p.y) < 0.5 ? std::floor(p.y) : std::ceil(p.y));
//        std::vector<cv::Point2i> ps = {p0, cv::Point2i(p0.x - 1, p0.y),
//                                       cv::Point2i(p0.x, p0.y - 1), cv::Point2i(p0.x - 1, p0.y - 1),
//        };
//
//
//        // compute the distance between point P and four center points
//        float sum_d = 0.f;
//        std::vector<float> ds = {};
//        for (int i = 0; i < 4; i++) {
//            cv::Point2f cp(ps[i].x + 0.5f, ps[i].y + 0.5f);
//            float d = std::sqrt(std::pow(p.x - cp.x, 2) + std::pow(p.y - cp.y, 2));
//            ds.push_back(d);
//            sum_d += d;
//        }
//
//        // assign colors by distance
//        for (int i = 0; i < 4; i++) {
//            float k = ds[i] / sum_d;
//            window.at<cv::Vec3b>(ps[i].y, ps[i].x)[1] = std::min(255.f,
//                                                                 window.at<cv::Vec3b>(ps[i].y, ps[i].x)[1] + 255.f * k);
//        };
//    }
//}

//void bezier(const std::vector<cv::Point2f> &control_points, cv::Mat &window) {
//    for (double t = 0.0; t <= 1.0; t += 0.001) {
//        cv::Point2f p = recursive_bezier(control_points, t);
//
//        // the four nearest points to point P
//        cv::Point2i p0(p.x - std::floor(p.x) < 0.5 ? std::floor(p.x) : std::ceil(p.x),
//                       p.y - std::floor(p.y) < 0.5 ? std::floor(p.y) : std::ceil(p.y));
//        std::vector<cv::Point2i> ps = {p0, cv::Point2i(p0.x - 1, p0.y),
//                                       cv::Point2i(p0.x, p0.y - 1), cv::Point2i(p0.x - 1, p0.y - 1),
//        };
//
//
//        // compute the distance between point P and four center points
//        float sum_d = 0.f;
//        std::vector<float> ds = {};
//        for (int i = 0; i < 4; i++) {
//            cv::Point2f cp(ps[i].x + 0.5f, ps[i].y + 0.5f);
//            float d = std::sqrt(std::pow(p.x - cp.x, 2) + std::pow(p.y - cp.y, 2));
//            ds.push_back(d);
//            sum_d += d;
//        }
//
//        // assign colors by distance
//        for (int i = 0; i < 4; i++) {
//            float k = ds[i] / sum_d;
//            window.at<cv::Vec3b>(ps[i].y, ps[i].x)[1] = std::min(255.f,
//                                                                 window.at<cv::Vec3b>(ps[i].y, ps[i].x)[1] + 255.f * k);
//        };
//    }
//    cv::Mat window_copy = window.clone();
//
//    float min_x = window.cols;
//    float max_x = 0;
//    float min_y = window.rows;
//    float max_y = 0;
//
//    // find out the bounding box of current line
//    for (int i = 0; i < control_points.size(); i++) {
//        min_x = std::min(control_points[i].x, min_x);
//        max_x = std::max(control_points[i].x, max_x);
//        min_y = std::min(control_points[i].y, min_y);
//        max_y = std::max(control_points[i].y, max_y);
//    }
//
//    for (int y = min_y; y < max_y; y++) {
//        for (int x = min_x; x < max_x; x++) {
//
//            for (float j = 0.25; j < 1.; j += 0.5) {
//                for (float i = 0.25; i < 1.; i += 0.5) {
//
//                    // find center coordinates
//                    int cx = i > 0.5 ? x + 1 : x;
//                    int cy = j > 0.5 ? y + 1 : y;
//                    if (cx > max_x || cy > max_y) continue;
//
//                    cv::Vec3b u00 = window_copy.at<cv::Vec3b>(cy - 0.5, cx - 0.5);
//                    cv::Vec3b u10 = window_copy.at<cv::Vec3b>(cy - 0.5, cx + 0.5);
//                    cv::Vec3b u01 = window_copy.at<cv::Vec3b>(cy + 0.5, cx - 0.5);
//                    cv::Vec3b u11 = window_copy.at<cv::Vec3b>(cy + 0.5, cx + 0.5);
//
//                    float s = (x + i) - (cx - 0.5);
//                    float t = (y + j) - (cy - 0.5);
//
//                    cv::Vec3b u0 = (1 - s) * u00 + s * u10;
//                    cv::Vec3b u1 = (1 - s) * u01 + s * u11;
//                    cv::Vec3b res = (1 - t) * u0 + t * u1;
//
//                    window.at<cv::Vec3b>(y, x)[0] = res[0];
//                    window.at<cv::Vec3b>(y, x)[1] = res[1];
//                    window.at<cv::Vec3b>(y, x)[2] = res[2];
//                }
//            }
//        }
//    }
//}

int main() {
    cv::Mat window = cv::Mat(700, 700, CV_8UC3, cv::Scalar(0));
    cv::cvtColor(window, window, cv::COLOR_BGR2RGB);
    cv::namedWindow("Bezier Curve", cv::WINDOW_AUTOSIZE);

    cv::setMouseCallback("Bezier Curve", mouse_handler, nullptr);

    int key = -1;
    while (key != 27) {
        window.setTo(0);
        for (auto &point: control_points) {
            cv::circle(window, point, 3, {255, 255, 255}, 3);
        }

        if (control_points.size() >= 4) {
            naive_bezier(control_points, window);
            bezier(control_points, window);

            cv::imshow("Bezier Curve", window);
            cv::imwrite("my_bezier_curve.png", window);
            key = cv::waitKey(1);

        }

        cv::imshow("Bezier Curve", window);
        key = cv::waitKey(20);
    }

    return 0;
}
