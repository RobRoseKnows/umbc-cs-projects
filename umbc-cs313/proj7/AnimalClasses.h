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


int Animal_eat(void *this, char *arg);

int Animal_speak(void *this, char *arg);

int Animal_display(void *this, char *arg);


int Lion_eat(void *this, char *arg);

int Lion_speak(void *this, char *arg);

int Lion_display(void *this, char *arg);


int Fish_eat(void *this, char *arg);

int Fish_speak(void *this, char *arg);

int Fish_display(void *this, char *arg);

int invoke(Animal *this, int method_slot, char *arg);
