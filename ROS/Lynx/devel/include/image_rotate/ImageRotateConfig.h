//#line 2 "/opt/ros/indigo/share/dynamic_reconfigure/cmake/../templates/ConfigType.h.template"
// *********************************************************
//
// File autogenerated for the image_rotate package
// by the dynamic_reconfigure package.
// Please do not edit.
//
// ********************************************************/

#ifndef __image_rotate__IMAGEROTATECONFIG_H__
#define __image_rotate__IMAGEROTATECONFIG_H__

#include <dynamic_reconfigure/config_tools.h>
#include <limits>
#include <ros/node_handle.h>
#include <dynamic_reconfigure/ConfigDescription.h>
#include <dynamic_reconfigure/ParamDescription.h>
#include <dynamic_reconfigure/Group.h>
#include <dynamic_reconfigure/config_init_mutex.h>
#include <boost/any.hpp>

namespace image_rotate
{
  class ImageRotateConfigStatics;

  class ImageRotateConfig
  {
  public:
    class AbstractParamDescription : public dynamic_reconfigure::ParamDescription
    {
    public:
      AbstractParamDescription(std::string n, std::string t, uint32_t l,
          std::string d, std::string e)
      {
        name = n;
        type = t;
        level = l;
        description = d;
        edit_method = e;
      }

      virtual void clamp(ImageRotateConfig &config, const ImageRotateConfig &max, const ImageRotateConfig &min) const = 0;
      virtual void calcLevel(uint32_t &level, const ImageRotateConfig &config1, const ImageRotateConfig &config2) const = 0;
      virtual void fromServer(const ros::NodeHandle &nh, ImageRotateConfig &config) const = 0;
      virtual void toServer(const ros::NodeHandle &nh, const ImageRotateConfig &config) const = 0;
      virtual bool fromMessage(const dynamic_reconfigure::Config &msg, ImageRotateConfig &config) const = 0;
      virtual void toMessage(dynamic_reconfigure::Config &msg, const ImageRotateConfig &config) const = 0;
      virtual void getValue(const ImageRotateConfig &config, boost::any &val) const = 0;
    };

    typedef boost::shared_ptr<AbstractParamDescription> AbstractParamDescriptionPtr;
    typedef boost::shared_ptr<const AbstractParamDescription> AbstractParamDescriptionConstPtr;

    template <class T>
    class ParamDescription : public AbstractParamDescription
    {
    public:
      ParamDescription(std::string a_name, std::string a_type, uint32_t a_level,
          std::string a_description, std::string a_edit_method, T ImageRotateConfig::* a_f) :
        AbstractParamDescription(a_name, a_type, a_level, a_description, a_edit_method),
        field(a_f)
      {}

      T (ImageRotateConfig::* field);

      virtual void clamp(ImageRotateConfig &config, const ImageRotateConfig &max, const ImageRotateConfig &min) const
      {
        if (config.*field > max.*field)
          config.*field = max.*field;

        if (config.*field < min.*field)
          config.*field = min.*field;
      }

      virtual void calcLevel(uint32_t &comb_level, const ImageRotateConfig &config1, const ImageRotateConfig &config2) const
      {
        if (config1.*field != config2.*field)
          comb_level |= level;
      }

      virtual void fromServer(const ros::NodeHandle &nh, ImageRotateConfig &config) const
      {
        nh.getParam(name, config.*field);
      }

      virtual void toServer(const ros::NodeHandle &nh, const ImageRotateConfig &config) const
      {
        nh.setParam(name, config.*field);
      }

      virtual bool fromMessage(const dynamic_reconfigure::Config &msg, ImageRotateConfig &config) const
      {
        return dynamic_reconfigure::ConfigTools::getParameter(msg, name, config.*field);
      }

      virtual void toMessage(dynamic_reconfigure::Config &msg, const ImageRotateConfig &config) const
      {
        dynamic_reconfigure::ConfigTools::appendParameter(msg, name, config.*field);
      }

      virtual void getValue(const ImageRotateConfig &config, boost::any &val) const
      {
        val = config.*field;
      }
    };

    class AbstractGroupDescription : public dynamic_reconfigure::Group
    {
      public:
      AbstractGroupDescription(std::string n, std::string t, int p, int i, bool s)
      {
        name = n;
        type = t;
        parent = p;
        state = s;
        id = i;
      }

      std::vector<AbstractParamDescriptionConstPtr> abstract_parameters;
      bool state;

      virtual void toMessage(dynamic_reconfigure::Config &msg, const boost::any &config) const = 0;
      virtual bool fromMessage(const dynamic_reconfigure::Config &msg, boost::any &config) const =0;
      virtual void updateParams(boost::any &cfg, ImageRotateConfig &top) const= 0;
      virtual void setInitialState(boost::any &cfg) const = 0;


      void convertParams()
      {
        for(std::vector<AbstractParamDescriptionConstPtr>::const_iterator i = abstract_parameters.begin(); i != abstract_parameters.end(); ++i)
        {
          parameters.push_back(dynamic_reconfigure::ParamDescription(**i));
        }
      }
    };

    typedef boost::shared_ptr<AbstractGroupDescription> AbstractGroupDescriptionPtr;
    typedef boost::shared_ptr<const AbstractGroupDescription> AbstractGroupDescriptionConstPtr;

    template<class T, class PT>
    class GroupDescription : public AbstractGroupDescription
    {
    public:
      GroupDescription(std::string a_name, std::string a_type, int a_parent, int a_id, bool a_s, T PT::* a_f) : AbstractGroupDescription(a_name, a_type, a_parent, a_id, a_s), field(a_f)
      {
      }

      GroupDescription(const GroupDescription<T, PT>& g): AbstractGroupDescription(g.name, g.type, g.parent, g.id, g.state), field(g.field), groups(g.groups)
      {
        parameters = g.parameters;
        abstract_parameters = g.abstract_parameters;
      }

      virtual bool fromMessage(const dynamic_reconfigure::Config &msg, boost::any &cfg) const
      {
        PT* config = boost::any_cast<PT*>(cfg);
        if(!dynamic_reconfigure::ConfigTools::getGroupState(msg, name, (*config).*field))
          return false;

        for(std::vector<AbstractGroupDescriptionConstPtr>::const_iterator i = groups.begin(); i != groups.end(); ++i)
        {
          boost::any n = &((*config).*field);
          if(!(*i)->fromMessage(msg, n))
            return false;
        }

        return true;
      }

      virtual void setInitialState(boost::any &cfg) const
      {
        PT* config = boost::any_cast<PT*>(cfg);
        T* group = &((*config).*field);
        group->state = state;

        for(std::vector<AbstractGroupDescriptionConstPtr>::const_iterator i = groups.begin(); i != groups.end(); ++i)
        {
          boost::any n = boost::any(&((*config).*field));
          (*i)->setInitialState(n);
        }

      }

      virtual void updateParams(boost::any &cfg, ImageRotateConfig &top) const
      {
        PT* config = boost::any_cast<PT*>(cfg);

        T* f = &((*config).*field);
        f->setParams(top, abstract_parameters);

        for(std::vector<AbstractGroupDescriptionConstPtr>::const_iterator i = groups.begin(); i != groups.end(); ++i)
        {
          boost::any n = &((*config).*field);
          (*i)->updateParams(n, top);
        }
      }

      virtual void toMessage(dynamic_reconfigure::Config &msg, const boost::any &cfg) const
      {
        const PT config = boost::any_cast<PT>(cfg);
        dynamic_reconfigure::ConfigTools::appendGroup<T>(msg, name, id, parent, config.*field);

        for(std::vector<AbstractGroupDescriptionConstPtr>::const_iterator i = groups.begin(); i != groups.end(); ++i)
        {
          (*i)->toMessage(msg, config.*field);
        }
      }

      T (PT::* field);
      std::vector<ImageRotateConfig::AbstractGroupDescriptionConstPtr> groups;
    };

class DEFAULT
{
  public:
    DEFAULT()
    {
      state = true;
      name = "Default";
    }

    void setParams(ImageRotateConfig &config, const std::vector<AbstractParamDescriptionConstPtr> params)
    {
      for (std::vector<AbstractParamDescriptionConstPtr>::const_iterator _i = params.begin(); _i != params.end(); ++_i)
      {
        boost::any val;
        (*_i)->getValue(config, val);

        if("target_frame_id"==(*_i)->name){target_frame_id = boost::any_cast<std::string>(val);}
        if("target_x"==(*_i)->name){target_x = boost::any_cast<double>(val);}
        if("target_y"==(*_i)->name){target_y = boost::any_cast<double>(val);}
        if("target_z"==(*_i)->name){target_z = boost::any_cast<double>(val);}
        if("source_frame_id"==(*_i)->name){source_frame_id = boost::any_cast<std::string>(val);}
        if("source_x"==(*_i)->name){source_x = boost::any_cast<double>(val);}
        if("source_y"==(*_i)->name){source_y = boost::any_cast<double>(val);}
        if("source_z"==(*_i)->name){source_z = boost::any_cast<double>(val);}
        if("output_frame_id"==(*_i)->name){output_frame_id = boost::any_cast<std::string>(val);}
        if("input_frame_id"==(*_i)->name){input_frame_id = boost::any_cast<std::string>(val);}
        if("use_camera_info"==(*_i)->name){use_camera_info = boost::any_cast<bool>(val);}
        if("max_angular_rate"==(*_i)->name){max_angular_rate = boost::any_cast<double>(val);}
        if("output_image_size"==(*_i)->name){output_image_size = boost::any_cast<double>(val);}
      }
    }

    std::string target_frame_id;
double target_x;
double target_y;
double target_z;
std::string source_frame_id;
double source_x;
double source_y;
double source_z;
std::string output_frame_id;
std::string input_frame_id;
bool use_camera_info;
double max_angular_rate;
double output_image_size;

    bool state;
    std::string name;

    
}groups;



//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      std::string target_frame_id;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double target_x;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double target_y;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double target_z;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      std::string source_frame_id;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double source_x;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double source_y;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double source_z;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      std::string output_frame_id;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      std::string input_frame_id;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      bool use_camera_info;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double max_angular_rate;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      double output_image_size;
//#line 218 "/opt/ros/indigo/share/dynamic_reconfigure/cmake/../templates/ConfigType.h.template"

    bool __fromMessage__(dynamic_reconfigure::Config &msg)
    {
      const std::vector<AbstractParamDescriptionConstPtr> &__param_descriptions__ = __getParamDescriptions__();
      const std::vector<AbstractGroupDescriptionConstPtr> &__group_descriptions__ = __getGroupDescriptions__();

      int count = 0;
      for (std::vector<AbstractParamDescriptionConstPtr>::const_iterator i = __param_descriptions__.begin(); i != __param_descriptions__.end(); ++i)
        if ((*i)->fromMessage(msg, *this))
          count++;

      for (std::vector<AbstractGroupDescriptionConstPtr>::const_iterator i = __group_descriptions__.begin(); i != __group_descriptions__.end(); i ++)
      {
        if ((*i)->id == 0)
        {
          boost::any n = boost::any(this);
          (*i)->updateParams(n, *this);
          (*i)->fromMessage(msg, n);
        }
      }

      if (count != dynamic_reconfigure::ConfigTools::size(msg))
      {
        ROS_ERROR("ImageRotateConfig::__fromMessage__ called with an unexpected parameter.");
        ROS_ERROR("Booleans:");
        for (unsigned int i = 0; i < msg.bools.size(); i++)
          ROS_ERROR("  %s", msg.bools[i].name.c_str());
        ROS_ERROR("Integers:");
        for (unsigned int i = 0; i < msg.ints.size(); i++)
          ROS_ERROR("  %s", msg.ints[i].name.c_str());
        ROS_ERROR("Doubles:");
        for (unsigned int i = 0; i < msg.doubles.size(); i++)
          ROS_ERROR("  %s", msg.doubles[i].name.c_str());
        ROS_ERROR("Strings:");
        for (unsigned int i = 0; i < msg.strs.size(); i++)
          ROS_ERROR("  %s", msg.strs[i].name.c_str());
        // @todo Check that there are no duplicates. Make this error more
        // explicit.
        return false;
      }
      return true;
    }

    // This version of __toMessage__ is used during initialization of
    // statics when __getParamDescriptions__ can't be called yet.
    void __toMessage__(dynamic_reconfigure::Config &msg, const std::vector<AbstractParamDescriptionConstPtr> &__param_descriptions__, const std::vector<AbstractGroupDescriptionConstPtr> &__group_descriptions__) const
    {
      dynamic_reconfigure::ConfigTools::clear(msg);
      for (std::vector<AbstractParamDescriptionConstPtr>::const_iterator i = __param_descriptions__.begin(); i != __param_descriptions__.end(); ++i)
        (*i)->toMessage(msg, *this);

      for (std::vector<AbstractGroupDescriptionConstPtr>::const_iterator i = __group_descriptions__.begin(); i != __group_descriptions__.end(); ++i)
      {
        if((*i)->id == 0)
        {
          (*i)->toMessage(msg, *this);
        }
      }
    }

    void __toMessage__(dynamic_reconfigure::Config &msg) const
    {
      const std::vector<AbstractParamDescriptionConstPtr> &__param_descriptions__ = __getParamDescriptions__();
      const std::vector<AbstractGroupDescriptionConstPtr> &__group_descriptions__ = __getGroupDescriptions__();
      __toMessage__(msg, __param_descriptions__, __group_descriptions__);
    }

    void __toServer__(const ros::NodeHandle &nh) const
    {
      const std::vector<AbstractParamDescriptionConstPtr> &__param_descriptions__ = __getParamDescriptions__();
      for (std::vector<AbstractParamDescriptionConstPtr>::const_iterator i = __param_descriptions__.begin(); i != __param_descriptions__.end(); ++i)
        (*i)->toServer(nh, *this);
    }

    void __fromServer__(const ros::NodeHandle &nh)
    {
      static bool setup=false;

      const std::vector<AbstractParamDescriptionConstPtr> &__param_descriptions__ = __getParamDescriptions__();
      for (std::vector<AbstractParamDescriptionConstPtr>::const_iterator i = __param_descriptions__.begin(); i != __param_descriptions__.end(); ++i)
        (*i)->fromServer(nh, *this);

      const std::vector<AbstractGroupDescriptionConstPtr> &__group_descriptions__ = __getGroupDescriptions__();
      for (std::vector<AbstractGroupDescriptionConstPtr>::const_iterator i = __group_descriptions__.begin(); i != __group_descriptions__.end(); i++){
        if (!setup && (*i)->id == 0) {
          setup = true;
          boost::any n = boost::any(this);
          (*i)->setInitialState(n);
        }
      }
    }

    void __clamp__()
    {
      const std::vector<AbstractParamDescriptionConstPtr> &__param_descriptions__ = __getParamDescriptions__();
      const ImageRotateConfig &__max__ = __getMax__();
      const ImageRotateConfig &__min__ = __getMin__();
      for (std::vector<AbstractParamDescriptionConstPtr>::const_iterator i = __param_descriptions__.begin(); i != __param_descriptions__.end(); ++i)
        (*i)->clamp(*this, __max__, __min__);
    }

    uint32_t __level__(const ImageRotateConfig &config) const
    {
      const std::vector<AbstractParamDescriptionConstPtr> &__param_descriptions__ = __getParamDescriptions__();
      uint32_t level = 0;
      for (std::vector<AbstractParamDescriptionConstPtr>::const_iterator i = __param_descriptions__.begin(); i != __param_descriptions__.end(); ++i)
        (*i)->calcLevel(level, config, *this);
      return level;
    }

    static const dynamic_reconfigure::ConfigDescription &__getDescriptionMessage__();
    static const ImageRotateConfig &__getDefault__();
    static const ImageRotateConfig &__getMax__();
    static const ImageRotateConfig &__getMin__();
    static const std::vector<AbstractParamDescriptionConstPtr> &__getParamDescriptions__();
    static const std::vector<AbstractGroupDescriptionConstPtr> &__getGroupDescriptions__();

  private:
    static const ImageRotateConfigStatics *__get_statics__();
  };

  template <> // Max and min are ignored for strings.
  inline void ImageRotateConfig::ParamDescription<std::string>::clamp(ImageRotateConfig &config, const ImageRotateConfig &max, const ImageRotateConfig &min) const
  {
    (void) config;
    (void) min;
    (void) max;
    return;
  }

  class ImageRotateConfigStatics
  {
    friend class ImageRotateConfig;

    ImageRotateConfigStatics()
    {
ImageRotateConfig::GroupDescription<ImageRotateConfig::DEFAULT, ImageRotateConfig> Default("Default", "", 0, 0, true, &ImageRotateConfig::groups);
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.target_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.target_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.target_frame_id = "base_link";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("target_frame_id", "str", 0, "Frame in which the target vector is specified. Empty means the input frame.", "", &ImageRotateConfig::target_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("target_frame_id", "str", 0, "Frame in which the target vector is specified. Empty means the input frame.", "", &ImageRotateConfig::target_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.target_x = -10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.target_x = 10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.target_x = 0.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("target_x", "double", 0, "X coordinate of the target vector", "", &ImageRotateConfig::target_x)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("target_x", "double", 0, "X coordinate of the target vector", "", &ImageRotateConfig::target_x)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.target_y = -10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.target_y = 10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.target_y = 0.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("target_y", "double", 0, "Y coordinate of the target vector", "", &ImageRotateConfig::target_y)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("target_y", "double", 0, "Y coordinate of the target vector", "", &ImageRotateConfig::target_y)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.target_z = -10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.target_z = 10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.target_z = 1.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("target_z", "double", 0, "Z coordinate of the target vector", "", &ImageRotateConfig::target_z)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("target_z", "double", 0, "Z coordinate of the target vector", "", &ImageRotateConfig::target_z)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.source_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.source_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.source_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("source_frame_id", "str", 0, "Frame in which the source vector is specified. Empty means the input frame.", "", &ImageRotateConfig::source_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("source_frame_id", "str", 0, "Frame in which the source vector is specified. Empty means the input frame.", "", &ImageRotateConfig::source_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.source_x = -10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.source_x = 10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.source_x = 0.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("source_x", "double", 0, "X coordinate of the direction the target should be aligned with.", "", &ImageRotateConfig::source_x)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("source_x", "double", 0, "X coordinate of the direction the target should be aligned with.", "", &ImageRotateConfig::source_x)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.source_y = -10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.source_y = 10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.source_y = -1.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("source_y", "double", 0, "Y coordinate of the direction the target should be aligned with.", "", &ImageRotateConfig::source_y)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("source_y", "double", 0, "Y coordinate of the direction the target should be aligned with.", "", &ImageRotateConfig::source_y)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.source_z = -10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.source_z = 10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.source_z = 0.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("source_z", "double", 0, "Z coordinate of the direction the target should be aligned with.", "", &ImageRotateConfig::source_z)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("source_z", "double", 0, "Z coordinate of the direction the target should be aligned with.", "", &ImageRotateConfig::source_z)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.output_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.output_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.output_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("output_frame_id", "str", 0, "Frame to publish for the image's new orientation. Empty means add '_rotated' suffix to the image frame.", "", &ImageRotateConfig::output_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("output_frame_id", "str", 0, "Frame to publish for the image's new orientation. Empty means add '_rotated' suffix to the image frame.", "", &ImageRotateConfig::output_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.input_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.input_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.input_frame_id = "";
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("input_frame_id", "str", 0, "Frame to use for the original camera image. Empty means that the frame in the image or camera_info should be used depending on use_camera_info.", "", &ImageRotateConfig::input_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<std::string>("input_frame_id", "str", 0, "Frame to use for the original camera image. Empty means that the frame in the image or camera_info should be used depending on use_camera_info.", "", &ImageRotateConfig::input_frame_id)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.use_camera_info = 0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.use_camera_info = 1;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.use_camera_info = 1;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<bool>("use_camera_info", "bool", 0, "Indicates that the camera_info topic should be subscribed to to get the default input_frame_id. Otherwise the frame from the image message will be used.", "", &ImageRotateConfig::use_camera_info)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<bool>("use_camera_info", "bool", 0, "Indicates that the camera_info topic should be subscribed to to get the default input_frame_id. Otherwise the frame from the image message will be used.", "", &ImageRotateConfig::use_camera_info)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.max_angular_rate = 0.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.max_angular_rate = 100.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.max_angular_rate = 10.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("max_angular_rate", "double", 0, "Limits the rate at which the image can rotate (rad/s). Zero means no limit.", "", &ImageRotateConfig::max_angular_rate)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("max_angular_rate", "double", 0, "Limits the rate at which the image can rotate (rad/s). Zero means no limit.", "", &ImageRotateConfig::max_angular_rate)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __min__.output_image_size = 0.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __max__.output_image_size = 3.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __default__.output_image_size = 2.0;
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.abstract_parameters.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("output_image_size", "double", 0, "Size of the output image as a function of the input image size. Can be varied continuously between the following special settings: 0 ensures no black ever appears, 1 is small image dimension, 2 is large image dimension, 3 is image diagonal.", "", &ImageRotateConfig::output_image_size)));
//#line 292 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __param_descriptions__.push_back(ImageRotateConfig::AbstractParamDescriptionConstPtr(new ImageRotateConfig::ParamDescription<double>("output_image_size", "double", 0, "Size of the output image as a function of the input image size. Can be varied continuously between the following special settings: 0 ensures no black ever appears, 1 is small image dimension, 2 is large image dimension, 3 is image diagonal.", "", &ImageRotateConfig::output_image_size)));
//#line 245 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      Default.convertParams();
//#line 245 "/opt/ros/indigo/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py"
      __group_descriptions__.push_back(ImageRotateConfig::AbstractGroupDescriptionConstPtr(new ImageRotateConfig::GroupDescription<ImageRotateConfig::DEFAULT, ImageRotateConfig>(Default)));
//#line 356 "/opt/ros/indigo/share/dynamic_reconfigure/cmake/../templates/ConfigType.h.template"

      for (std::vector<ImageRotateConfig::AbstractGroupDescriptionConstPtr>::const_iterator i = __group_descriptions__.begin(); i != __group_descriptions__.end(); ++i)
      {
        __description_message__.groups.push_back(**i);
      }
      __max__.__toMessage__(__description_message__.max, __param_descriptions__, __group_descriptions__);
      __min__.__toMessage__(__description_message__.min, __param_descriptions__, __group_descriptions__);
      __default__.__toMessage__(__description_message__.dflt, __param_descriptions__, __group_descriptions__);
    }
    std::vector<ImageRotateConfig::AbstractParamDescriptionConstPtr> __param_descriptions__;
    std::vector<ImageRotateConfig::AbstractGroupDescriptionConstPtr> __group_descriptions__;
    ImageRotateConfig __max__;
    ImageRotateConfig __min__;
    ImageRotateConfig __default__;
    dynamic_reconfigure::ConfigDescription __description_message__;

    static const ImageRotateConfigStatics *get_instance()
    {
      // Split this off in a separate function because I know that
      // instance will get initialized the first time get_instance is
      // called, and I am guaranteeing that get_instance gets called at
      // most once.
      static ImageRotateConfigStatics instance;
      return &instance;
    }
  };

  inline const dynamic_reconfigure::ConfigDescription &ImageRotateConfig::__getDescriptionMessage__()
  {
    return __get_statics__()->__description_message__;
  }

  inline const ImageRotateConfig &ImageRotateConfig::__getDefault__()
  {
    return __get_statics__()->__default__;
  }

  inline const ImageRotateConfig &ImageRotateConfig::__getMax__()
  {
    return __get_statics__()->__max__;
  }

  inline const ImageRotateConfig &ImageRotateConfig::__getMin__()
  {
    return __get_statics__()->__min__;
  }

  inline const std::vector<ImageRotateConfig::AbstractParamDescriptionConstPtr> &ImageRotateConfig::__getParamDescriptions__()
  {
    return __get_statics__()->__param_descriptions__;
  }

  inline const std::vector<ImageRotateConfig::AbstractGroupDescriptionConstPtr> &ImageRotateConfig::__getGroupDescriptions__()
  {
    return __get_statics__()->__group_descriptions__;
  }

  inline const ImageRotateConfigStatics *ImageRotateConfig::__get_statics__()
  {
    const static ImageRotateConfigStatics *statics;

    if (statics) // Common case
      return statics;

    boost::mutex::scoped_lock lock(dynamic_reconfigure::__init_mutex__);

    if (statics) // In case we lost a race.
      return statics;

    statics = ImageRotateConfigStatics::get_instance();

    return statics;
  }


}

#endif // __IMAGEROTATERECONFIGURATOR_H__