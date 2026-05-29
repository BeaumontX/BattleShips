#include "grid.h"

using namespace godot;

void Grid::_bind_methods() {
    ClassDB::bind_method(D_METHOD("get_grid"), &Grid::get_grid);
    ClassDB::bind_method(D_METHOD("set_grid", "value"), &Grid::set_grid);

    ADD_PROPERTY(
        PropertyInfo(
            Variant::DICTIONARY,
            "grid",
            PROPERTY_HINT_DICTIONARY_TYPE,
            "Vector2i;int"
        ),
        "set_grid",
        "get_grid"
    );


    ClassDB::bind_method(D_METHOD("SetCell", "coordinates", "value"), &Grid::SetCell);
    ClassDB::bind_method(D_METHOD("IntsToVector", "x", "y"), &Grid::IntsToVector);
}