#pragma warning (disable :4996)
#undef _CRT_SECURE_NO_DEPRECATE
#include "XnCppWrapper.h"
#include <io/capture_realsense.hpp>

using namespace std;
using namespace xn;

//const std::string XMLConfig =
//"<OpenNI>"
//        "<Licenses>"
//        "<License vendor=\"PrimeSense\" key=\"0KOIk2JeIBYClPWVnMoRKn5cdY4=\"/>"
//        "</Licenses>"
//        "<Log writeToConsole=\"false\" writeToFile=\"false\">"
//                "<LogLevel value=\"3\"/>"
//                "<Masks>"
//                        "<Mask name=\"ALL\" on=\"true\"/>"
//                "</Masks>"
//                "<Dumps>"
//                "</Dumps>"
//        "</Log>"
//        "<ProductionNodes>"
//                "<Node type=\"Image\" name=\"Image1\">"
//                        "<Configuration>"
//                                "<MapOutputMode xRes=\"640\" yRes=\"480\" FPS=\"30\"/>"
//                                "<Mirror on=\"false\"/>"
//                        "</Configuration>"
//                "</Node> "
//                "<Node type=\"Depth\" name=\"Depth1\">"
//                        "<Configuration>"
//                                "<MapOutputMode xRes=\"640\" yRes=\"480\" FPS=\"30\"/>"
//                                "<Mirror on=\"false\"/>"
//                        "</Configuration>"
//                "</Node>"
//        "</ProductionNodes>"
//"</OpenNI>";

#define REPORT_ERROR(msg) kfusion::cuda::error ((msg), __FILE__, __LINE__)
//
//struct kfusion::RealsenseSource::Impl
//{
//    Context context;
//    ScriptNode scriptNode;
//    DepthGenerator depth;
//    ImageGenerator image;
//    ProductionNode node;
//    DepthMetaData depthMD;
//    ImageMetaData imageMD;
//    XnChar strError[1024];
//    Player player_;
//
//    bool has_depth;
//    bool has_image;
//};
struct kfusion::RealsenseSource::Impl
{
	rs::context rs;
	rs::device * dev;
	uint16_t one_meter;
};

//kfusion::RealsenseSource::RealsenseSource() : depth_focal_length_VGA (0.f), baseline (0.f),
//    shadow_value (0), no_sample_value (0), pixelSize (0.0), max_depth (0) {}

kfusion::RealsenseSource::RealsenseSource(int device) {open (device); }
//kfusion::RealsenseSource::RealsenseSource(const string& filename, bool repeat /*= false*/) {open (filename, repeat); }
kfusion::RealsenseSource::~RealsenseSource() { release (); }

void kfusion::RealsenseSource::open(int device){
	impl_ = cv::Ptr<Impl>(new Impl());
	rs::log_to_console(rs::log_severity::warn);
	impl_->dev = impl_->rs.get_device(0);
	printf("\nUsing device 0, an %s\n", impl_->dev->get_name());
	printf("    Serial number: %s\n", impl_->dev->get_serial());
	printf("    Firmware version: %s\n", impl_->dev->get_firmware_version());

	// Configure depth to run at VGA resolution at 30 frames per second
	impl_->dev->enable_stream(rs::stream::depth, 640, 480, rs::format::z16, 60);
	impl_->dev->enable_stream(rs::stream::color, 640, 480, rs::format::z16, 60);
	//dev.enable_stream(rs::stream::depth, rs::preset::best_quality);
	//dev.enable_stream(rs::stream::color, rs::preset::best_quality);
	impl_->dev->start();
	impl_->one_meter = static_cast<uint16_t>(1.0f / impl_->dev->get_depth_scale());
}
void kfusion::RealsenseSource::release(){
	//impl_->release();
}
bool kfusion::RealsenseSource::grab(cv::Mat &depth, cv::Mat &image){
	impl_->dev->wait_for_frames();
	const uint16_t * depth_frame = reinterpret_cast<const uint16_t *>(impl_->dev->get_frame_data(rs::stream::depth));
	const uint8_t * color_frame = reinterpret_cast<const uint8_t *>(impl_->dev->get_frame_data(rs::stream::color));
	int x_depth = impl_->dev->get_stream_width(rs::stream::depth);
	int y_depth = impl_->dev->get_stream_height(rs::stream::depth);
	cv::Mat(y_depth, x_depth, CV_16U, (void*)depth_frame).copyTo(depth);
}
