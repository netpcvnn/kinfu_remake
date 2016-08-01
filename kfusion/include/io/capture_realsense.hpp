#pragma once

#include <kfusion/kinfu.hpp>
#include <opencv2/core/core.hpp>
#include <string>
#include <librealsense/rs.hpp>
#include <cstdio>

namespace kfusion
{
    class KF_EXPORTS RealsenseSource
    {
    public:
        typedef kfusion::PixelRGB RGB24;

        enum { PROP_OPENNI_REGISTRATION_ON  = 104 };

        RealsenseSource();
        RealsenseSource(int device);
        //RealsenseSource(const std::string& oni_filename, bool repeat = false);

        void open(int device);
        //void open(const std::string& oni_filename, bool repeat = false);
        void release();

        ~RealsenseSource();

        bool grab(cv::Mat &depth, cv::Mat &image);

        //parameters taken from camera/oni
        int shadow_value, no_sample_value;
        float depth_focal_length_VGA;
        float baseline;               // mm
        double pixelSize;             // mm
        unsigned short max_depth;     // mm

        bool setRegistration (bool value = false);
    private:
        struct Impl;
        cv::Ptr<Impl> impl_;
        void getParams ();

    };
}
