#pragma once

#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/variant/vector2i.hpp> 
#include <godot_cpp/variant/typed_dictionary.hpp>
#include <godot_cpp/variant/string_name.hpp>


class Grid : public godot::Resource {
    GDCLASS(Grid, godot::Resource)

protected:
    static void _bind_methods();

private:
    godot::Vector2i size;

    godot::TypedDictionary<godot::Vector2i, int> grid;

public:
    godot::TypedDictionary<godot::Vector2i, int> get_grid() const { return grid; }
    void set_grid(const godot::TypedDictionary<godot::Vector2i, int>& p_dict) { grid = p_dict; }
};
