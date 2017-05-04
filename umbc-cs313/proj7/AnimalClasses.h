#define EAT_METHOD 0
#define SPEAK_METHOD 1
#define DISPLAY_METHOD 2


typedef struct {

    int (**vtable)(void *, char *);

    char *name;
    int weight;
    char *sound;

} Animal;


typedef struct {

    int (**vtable)(void *, char *);
    
    char *name;
    int weight;
    char *sound;
    
    int is_alpha_male; /* used as boolean */
    
} Lion;


typedef struct {
    
    int(**vtable)(void *, char *);

    char *name;
    int weight;
    char *sound;

    char *fin_type;

} Fish;



Animal *new_Animal(void);

Lion *new_Lion(void);

Fish *new_Fish(void);


int invoke(Animal *this, int method_slot, char *arg);
