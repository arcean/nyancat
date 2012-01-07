#ifndef OBJECT_H
#define OBJECT_H

class Object
{
public:
    Object(int x_pos, int y_pos, int width, int height, int type);

public:
    int get_x_pos() const;
    int get_y_pos() const;
    int get_type() const;
    int get_width() const;
    int get_height() const;
    void set_x_pos(int x_pos);
    void set_y_pos(int y_pos);
    void set_width(int width);
    void set_height(int height);
    void set_type(int type);

private:
    int x_pos;
    int y_pos;
    int width;
    int height;
    int type;
};

#endif // OBJECT_H
