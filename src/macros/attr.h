#define PASTE(x,y) x##_##y
#define getattr(x,y) PASTE(x,y)
#define STRINGIFY1(x) #x
#define STRINGIFY(x) STRINGIFY1(x)
