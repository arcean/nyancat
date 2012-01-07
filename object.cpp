#include "object.h"

Object::Object(int x_pos, int y_pos, int width, int height, int type)
{
    this->x_pos = x_pos;
    this->y_pos = y_pos;
    this->width = width;
    this->height = height;
    this->type = type;
}

int Object::get_x_pos() const
{
    return this->x_pos;
}

int Object::get_y_pos() const
{
    return this->y_pos;
}

int Object::get_width() const
{
    return this->width;
}

int Object::get_height() const
{
    return this->height;
}

int Object::get_type() const
{
    return this->type;
}

void Object::set_x_pos(int x_pos)
{
    this->x_pos = x_pos;
}

void Object::set_y_pos(int y_pos)
{
    this->y_pos = y_pos;
}

void Object::set_width(int width)
{
    this->width = width;
}

void Object::set_height(int height)
{
    this->height = height;
}

void Object::set_type(int type)
{
    this->type = type;
}
