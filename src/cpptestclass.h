#pragma once

#include <godot_cpp/classes/node.hpp>




// No namespace wrapper here
class cpptestclass : public godot::Node {
    GDCLASS(cpptestclass, godot::Node) // Must use godot:: here too

protected:
    static void _bind_methods();

};


