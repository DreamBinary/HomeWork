1. #### result

   no_sample

   <img src="\img\no_sample.jpg" alt="no_sample" width="250" />

   super_sampling_with_blackedge

   <img src="\img\super_sampling_blackedge.jpg" alt="no_sample" width="250" />

   super_sampling

   <img src="\img\super_sampling.jpg" alt="no_sample" width="250" />

2. #### code

   ```c++
   static bool insideTriangle(float x, float y, const Vector3f* _v){   
       // TODO : Implement this function to check if the point (x, y) is inside the triangle represented by _v[0], _v[1], _v[2]
       auto [c1, c2, c3] = computeBarycentric2D(x, y, _v);
       return (c1 >= 0 && c2 >= 0 && c3 >= 0);
   }
   ```

   check if the point (x, y) is inside the triangle by barycentic

   ```c++
   for (int x = min_x; x <= max_x; ++x) {
           for (int y = min_y; y <= max_y; ++y) {
               // Eigen::Vector3f color = t.getColor();
               // set_pixel(Eigen::Vector3f(x, y, 0), color);
               float xx = x + 0.5f;
               float yy = y + 0.5f;
               if (insideTriangle(xx, yy, t.v)) {
                   // super-sampling
                   int num_samples = 4; // 2x2 sub-pixels
                   bool update = false;
                   float dx[] = {-1, -1, 1, 1};
                   float dy[] = {-1, 1, -1, 1};
                   for (int i = 0; i < num_samples; ++i) {
                    float subpixel_x = xx + dx[i] * 0.25f;
                       float subpixel_y = yy + dy[i] * 0.25f;
                    if (insideTriangle(subpixel_x, subpixel_y, t.v)) {
                           float alpha, beta, gamma;
                           std::tie(alpha, beta, gamma) = computeBarycentric2D(xx, yy, t.v);
                           float w_reciprocal = 1.0f / (alpha / v[0].w() + beta / v[1].w() + gamma / v[2].w());
                           float z_interpolated =
                                   alpha * v[0].z() / v[0].w() + beta * v[1].z() / v[1].w() + gamma * v[2].z() / v[2].w();
                           z_interpolated *= w_reciprocal;
                           int index = get_sample_index(x * 2 + i % 2, y * 2 + i / 2);
                           if (z_interpolated < sample_depth_buf[index]) {
                               update = true;
                               sample_depth_buf[index] = z_interpolated;
                               Eigen::Vector3f color = t.getColor();
                               sample_frame_buf[index] = color;
                           }
                       }
                   }
                   if (update) {
                       // TODO setcolor
                   }
               }
        }
       }
   ```
   
   super-sampling  by 2x2 sub-pixels; use sample_depth_buf to update z_interpolated; use sample_frame_buf to record color of subpixel;
   
   ```c++
   Eigen::Vector3f color = (sample_frame_buf[get_sample_index(x * 2, y * 2)] +
   						sample_frame_buf[get_sample_index(x * 2 + 1, y * 2)] +
                           sample_frame_buf[get_sample_index(x * 2, y * 2 + 1)] +
                           sample_frame_buf[get_sample_index(x * 2 + 1, y * 2 + 1)]) /
                           4.0f;
   set_pixel(Eigen::Vector3f(x, y, 0), color);
   ```
   
   set color of pixel with avg of subpixels
   
   ```c++
   std::vector<Eigen::Vector3f> sample_frame_buf;
   std::vector<float> sample_depth_buf;
   ....
   sample_frame_buf.resize(w * h * 4);
   sample_depth_buf.resize(w * h * 4);
   ....
   int rst::rasterizer::get_sample_index(int x, int y) {
       return (height * 2 - 1 - y) * width * 2 + x;
   }
   ```
   
   init sample_frame_buf and sample_depth_buf as frame_buf and depth_buf;
   
   use sample_frame_buf and sample_depth_buf to confirm dismiss of black edge



