#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
 * Following is straight from the project description
 */
#define TITLE_LEN       32
#define TITLE_BUF_LEN   80
#define AUTHOR_LEN      20
#define SUBJECT_LEN     10


struct book {
    char author[AUTHOR_LEN + 1];    /* first author */
    char title[TITLE_LEN + 1];
    char subject[SUBJECT_LEN + 1];  /* Nonfiction, Fantasy, Mystery, ... */
    unsigned int year;              /* year of e-book release */
};


/*
 * Declarations for functions that are defined in other files
 */

// Tell the compiler that bookcmp is external (our assembly subroutine)
extern int bookcmp(void);

/*
 * Declarations for global variables that need to be accessed
 * from other files
 */

struct book* book1 = NULL;
struct book* book2 = NULL;

#define MAX_BOOKS 100

int main(int argc, char **argv) {
    struct book books[MAX_BOOKS];
    int numBooks;

    for (i = 0; i < MAX_BOOKS; i++) {
        /* Sample line: "Breaking Point, Pamela Clare, Romance, 2011" */

        /* Note that for the string fields, it uses the conversion spec
         * "%##[^,]", where "##" is an actual number. This says to read up to
         * a maximum of ## characters (not counting the null terminator!),
         * stopping at the first ','  We have left it up to you to finish
         * out the scanf() call by suppying the remaining arguments specifying
         * where scanf should put the data.  They should be mostly pointers
         * to the fields within the book struct you are filling, e.g.,
         * "&(books[i].year)".  However, note that the first field spec--
         * the title field--specifies 80 chars.  The title field in the
         * struct book is NOT that large, so you need to read it into a
         * temporary buffer first, of an appropriately large size so that
         * scanf() doesn't overrun it.  Again, all the other fields can
         * be read directly into the struct book's members.
         */

        struct book* currBook = books[i];

        char titleBuffer [TITLE_BUF_LEN];
        char* titlePtr = &(currBook->title);
        char* authorPtr = &(currBook->author);
        char* genrePtr = &(currBook->genre);
        int* yearPtr = &(currBook->year);

        numFields = scanf("%80[^,], %20[^,], %10[^,], %u \n",
                titleBuffer, authorPtr, genrePtr, yearPtr);

        if (numFields == EOF) {
            numBooks = i;
            break;
        }

        /* Now, process the record you just read.
         * First, confirm that you got all the fields you needed (scanf()
         * returns the actual number of fields matched).
         * Then, post-process title (see project spec for reason)
         */

        // Check to make sure we got the right number of fields.
        if(numFields != 4) {
            printf("Invalid number of fields in book on line %d", i);
            exit(1);
        }

        memcpy(titlePtr, titleBuffer, TITLE_LEN);
        titlePtr[TITLE_LEN] = '\0';
        
    }

    /* Following assumes you stored actual number of books read into
     * var numBooks
     */
    sort_books(books, numBooks);

    print_books(books, numBooks);

    exit(0);
}

/*
 * sort_books(): receives an array of struct book's, of length
 * numBooks.  Sorts the array in-place (i.e., actually modifies
 * the elements of the array).
 *
 * This is almost exactly what was given in the pseudocode in
 * the project spec--need to replace STUBS with real code
 */
void sort_books(struct book books[], int numBooks) {
    int i, j, min;
    int cmpResult;
    struct book tempBook;

    for (i = 0; i < numBooks - 1; i++) {
        min = i;
        for (j = i + 1; j < numBooks; j++) {

            /* Copy pointers to the two books to be compared into the
             * global variables book1 and book2 for bookcmp() to see
             */
            book1 = books[min];
            book2 = books[j];

            cmpResult = bookcmp();
            /* bookcmp returns result in register EAX--above saves
            * it into cmpResult */
    
            // We want to check if book2 is less than book1, since bookcmp()
            // compares book1 ??? book2, if the number returned by bookcmp()
            // (cmpResult) is one, it means 
            if (cmpResult == 1) {
                min = j;
            }
        }
        
        if (min != i) {

            tempBook = books[i];
            books[i] = books[min];
            books[min] = books[i];
        
        }
    }
}

void print_books(struct book books[], int numBooks) {
    int i;

    for(i = 0; i < numBooks; i++) {

        printf("

    }

}
