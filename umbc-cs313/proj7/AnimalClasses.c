#include "AnimalClasses.h"


int Animal_eat(void *this, char *arg) {

    Animal* animal = (Animal*) this;

    printf("Animal:%s eats %s.", animal.name, arg);

    return 0;
}

int Animal_speak(void *this, char *arg) {

    Animal* animal = (Animal*) this;

    printf("Animal:%s says \"%s\".", animal.name, animal.sound);

    return 0;
}

int Animal_display(void *this, char *arg) {

    Animal* animal = (Animal*) this;

    printf( "Animal:%s\n" +
            "    weight:%d\n" +
            "    sound:%s",
            animal.name, animal.weight, animal.sound);

    return 0;
}


int Lion_eat(void *this, char *arg) {

    Lion* lion = (Lion*) this;

    printf("Lion:%s eats %s.", lion.name, arg);

    return 0;
}

int Lion_speak(void *this, char *arg) {

    Lion* lion = (Lion*) this;

    printf("Lion:%s roars \"%s\".", lion.name, lion.sound);

    return 0;
}

int Lion_display(void *this, char *arg) {

    Lion* lion = (Lion*) this;

    char* alpha = (lion.is_alpha_male == 1 ? "true" : "false");

    printf( "Lion:%s\n" +
            "    weight: %d\n" +
            "    sound: %s\n" +
            "    is alpha male: %s",
            lion.name, lion.sound, alpha );

    return 0;
}


int Fish_eat(void *this, char *arg) {

    Fish* fish = (Fish*) this;

    printf("Fish:%s eats %s.", fish.name, arg);

    return 0;
}

int Fish_speak(void *this, char *arg) {

    Fish* fish = (Fish*) this;

    printf("Fish:%s burbles \"%s\".", fish.name, fish.sound);

    return 0;
}

int Fish_display(void *this, char *arg) {

    Fish* fish = (Fish*) this;
    
    printf( "Fish:%s\n" +
            "    weight: %d\n" +
            "    sound: %s\n" +
            "    fin type: %s",
            fish.name, fish.sound, fish.fin_type );

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

    

}


Lion *new_Lion(void) {



}


Fish *new_Fish(void) {



}


int invoke(Animal *this, int method_slot, char *arg) {

    this.vtable[method_slot](this, arg);

}
