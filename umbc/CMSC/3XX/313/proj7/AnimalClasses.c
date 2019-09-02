#include "AnimalClasses.h"
#include <stdlib.h>
#include <stdio.h>

int Animal_eat(void *this, char *arg) {

    Animal* animal = (Animal*) this;

    printf("Animal:%s eats %s.\n", animal->name, arg);

    return 0;
}

int Animal_speak(void *this, char *arg) {

    Animal* animal = (Animal*) this;

    printf("Animal:%s says \"%s\".\n", animal->name, animal->sound);

    return 0;
}

int Animal_display(void *this, char *arg) {

    Animal* animal = (Animal*) this;

    printf( "Animal:%s\nweight:%d\nsound:%s\n",
            animal->name, animal->weight, animal->sound);

    return 0;
}


int Lion_eat(void *this, char *arg) {

    Lion* lion = (Lion*) this;

    printf("Lion:%s eats %s.\n", lion->name, arg);

    return 0;
}

int Lion_speak(void *this, char *arg) {

    Lion* lion = (Lion*) this;

    printf("Lion:%s roars \"%s\".\n", lion->name, lion->sound);

    return 0;
}

int Lion_display(void *this, char *arg) {

    Lion* lion = (Lion*) this;

    char* alpha = (lion->is_alpha_male == 1 ? "true" : "false");

    printf( "Lion:%s\nweight: %d\nsound: %s\nis alpha male: %s\n",
            lion->name, lion->weight, lion->sound, alpha );

    return 0;
}


int Fish_eat(void *this, char *arg) {

    Fish* fish = (Fish*) this;

    printf("Fish:%s eats %s.\n", fish->name, arg);

    return 0;
}

int Fish_speak(void *this, char *arg) {

    Fish* fish = (Fish*) this;

    printf("Fish:%s burbles \"%s\".\n", fish->name, fish->sound);

    return 0;
}

int Fish_display(void *this, char *arg) {

    Fish* fish = (Fish*) this;
    
    printf( "Fish:%s\nweight: %d\nsound: %s\nfin type: %s\n",
            fish->name, fish->weight, fish->sound, fish->fin_type );

    return 0;
}


static int (*Animal_vtable[3])(void *, char *) = {

    &Animal_eat,
    &Animal_speak,
    &Animal_display

};

static int (*Lion_vtable[3])(void *, char *) = {

    &Lion_eat,
    &Lion_speak,
    &Lion_display

};


static int (*Fish_vtable[3])(void *, char *) = {

    &Fish_eat,
    &Fish_speak,
    &Fish_display

};


Animal *new_Animal(void) {

    Animal *x = (Animal*)malloc(sizeof(Animal));
    x->vtable = Animal_vtable;
    return x;

}


Lion *new_Lion(void) {

    Lion *x = (Lion*)malloc(sizeof(Lion));
    x->vtable = Lion_vtable;
    return x;

}


Fish *new_Fish(void) {

    Fish *x = (Fish*)malloc(sizeof(Fish));
    x->vtable = Fish_vtable;
    return x;

}


int invoke(Animal *this, int method_slot, char *arg) {

    return this->vtable[method_slot](this, arg);

}
