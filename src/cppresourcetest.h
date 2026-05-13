#pragma once

#include <godot_cpp/classes/resource.hpp>





class cppresourcetest : public godot::Resource {
    GDCLASS(cppresourcetest, godot::Resource) // Must use godot:: here too

protected:
    static void _bind_methods();

};
