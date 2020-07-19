// Generated by gencpp from file whycon/SetNumberOfTargets.msg
// DO NOT EDIT!


#ifndef WHYCON_MESSAGE_SETNUMBEROFTARGETS_H
#define WHYCON_MESSAGE_SETNUMBEROFTARGETS_H

#include <ros/service_traits.h>


#include <whycon/SetNumberOfTargetsRequest.h>
#include <whycon/SetNumberOfTargetsResponse.h>


namespace whycon
{

struct SetNumberOfTargets
{

typedef SetNumberOfTargetsRequest Request;
typedef SetNumberOfTargetsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct SetNumberOfTargets
} // namespace whycon


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::whycon::SetNumberOfTargets > {
  static const char* value()
  {
    return "e15bc5263e6150f9a266c2eb4b4dc901";
  }

  static const char* value(const ::whycon::SetNumberOfTargets&) { return value(); }
};

template<>
struct DataType< ::whycon::SetNumberOfTargets > {
  static const char* value()
  {
    return "whycon/SetNumberOfTargets";
  }

  static const char* value(const ::whycon::SetNumberOfTargets&) { return value(); }
};


// service_traits::MD5Sum< ::whycon::SetNumberOfTargetsRequest> should match 
// service_traits::MD5Sum< ::whycon::SetNumberOfTargets > 
template<>
struct MD5Sum< ::whycon::SetNumberOfTargetsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::whycon::SetNumberOfTargets >::value();
  }
  static const char* value(const ::whycon::SetNumberOfTargetsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::whycon::SetNumberOfTargetsRequest> should match 
// service_traits::DataType< ::whycon::SetNumberOfTargets > 
template<>
struct DataType< ::whycon::SetNumberOfTargetsRequest>
{
  static const char* value()
  {
    return DataType< ::whycon::SetNumberOfTargets >::value();
  }
  static const char* value(const ::whycon::SetNumberOfTargetsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::whycon::SetNumberOfTargetsResponse> should match 
// service_traits::MD5Sum< ::whycon::SetNumberOfTargets > 
template<>
struct MD5Sum< ::whycon::SetNumberOfTargetsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::whycon::SetNumberOfTargets >::value();
  }
  static const char* value(const ::whycon::SetNumberOfTargetsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::whycon::SetNumberOfTargetsResponse> should match 
// service_traits::DataType< ::whycon::SetNumberOfTargets > 
template<>
struct DataType< ::whycon::SetNumberOfTargetsResponse>
{
  static const char* value()
  {
    return DataType< ::whycon::SetNumberOfTargets >::value();
  }
  static const char* value(const ::whycon::SetNumberOfTargetsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // WHYCON_MESSAGE_SETNUMBEROFTARGETS_H