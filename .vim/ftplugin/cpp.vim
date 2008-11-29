" OmniCppComplete initialization
call omni#cpp#complete#Init()

" Library INClude: #include <>
imap linc<SPACE><SPACE> #include<SPACE><><LEFT>
" Project INClude: #include ""
imap pinc<SPACE><SPACE> #include<SPACE>""<LEFT>

" Include IOstream library
imap iio<SPACE><SPACE> #include<SPACE><iostream><CR>

" Include STRing container
imap istr<SPACE><SPACE> #include<SPACE><string><CR>

" Include VECtor container
imap ivec<SPACE><SPACE> #include<SPACE><vector><CR>

" Inculde MAP container
imap imap<SPACE><SPACE> #include<SPACE><map><CR>

" Include LiST container
imap ilst<SPACE><SPACE> #include<SPACE><list><CR>

" using namespace std
imap uns<SPACE><SPACE> using<SPACE>namespace<SPACE>std;<CR>

" main func.
imap main<SPACE><SPACE> int<SPACE>main(int argc, char **argv) {<CR>return<SPACE>EXIT_SUCCESS;<DOWN><BACKSPACE><UP><ESC>O//

" char *
imap pch<SPACE><SPACE> char<SPACE>*

"int *
imap pint<SPACE><SPACE> int<SPACE>*

" map<string, string>
imap mapss<SPACE><SPACE> map<string,<SPACE>string><SPACE>;<LEFT>

" vector<string>
imap vecs<SPACE><SPACE> vector<string><SPACE>;<LEFT>

" vector<int>
imap veci<SPACE><SPACE> vector<int><SPACE>;<LEFT>

" vector<unsigned int>
imap vecui<SPACE><SPACE> vector<unsigned<SPACE>int><SPACE>;<LEFT>

" vector<>;
imap vec<SPACE><SPACE> vector<><SPACE>;<LEFT><LEFT><LEFT>

" map<>;
imap map<SPACE><SPACE> map<><SPACE>;<LEFT><LEFT><LEFT>

" list<>;
imap lst<SPACE><SPACE> list<><SPACE>;<LEFT><LEFT><LEFT>
