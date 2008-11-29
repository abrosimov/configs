" OmniCppComplete initialization
call omni#cpp#complete#Init()

imap #inc<SPACE><SPACE> #include<SPACE><><LEFT>
imap #def<SPACE><SPACE> #define<SPACE>

imap iio<SPACE><SPACE> #include<SPACE><stdio.h><CR>

imap istdl<SPACE><SPACE> #include<SPACE><stdlib.h><CR>

imap imalloc<SPACE><SPACE> #include<SPACE><malloc.h><CR>

" main func.
imap main<SPACE><SPACE> int<SPACE>main(int argc, char **argv) {<CR>return<SPACE>EXIT_SUCCESS;<DOWN><BACKSPACE><UP><ESC>O//

imap istr<SPACE><SPACE> #include<SPACE><string.h><CR>
