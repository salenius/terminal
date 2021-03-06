###############
## Bash_profile-tiedosto
## Author: Tommi Salenius
## Email: tommisalenius@gmail.com
## License: GPL (2018)
###############

# Aseta värit terminaaliin globaalisti
export CLICOLOR=1
export LSCOLORS='GxFxCxDxBxegedabagaced'
PS1='\e[32;1m\h \e[33m\W\e[0m: '

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

# added by Anaconda3 5.1.0 installer
export PATH="/anaconda3/bin:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
PYTHONPATH="/Users/tommi/Python:$PYTHONPATH"
export PYTHONPATH

# added by Anaconda3 5.1.0 installer
export PATH="/Applications/anaconda3/bin:$PATH"

# Luo Python-konsolin käynnistyessä aktivoituva moduuli
export PYTHONSTARTUP="$HOME/.pythonrc"

# Aseta Golangille polku
export GOROOT="/usr/local/go"
export GOPATH="/Users/tommi/Golang"
export PATH="/Users/tommi/Golang/bin:$PATH"

# Aseta MongoDB:lle polku
export PATH="/usr/local/Cellar/mongodb/3.6.4/bin:$PATH"

# Aseta NPM:lle polku virheiden välttämiseksi
export PATH="/Users/tommi/.npm-global/bin:$PATH"

# Xdotoolia varten
export DISPLAY=':0.0'


######### Javaa varten ###########

## Tällä saat käännettyä ja ajettua automaattisesti Java-apektin
javacomp(){
javakansio=/Users/tommi/JavaProjects/src/$1 ; #Hae tiedostot täältä
classkansio=/Users/tommi/JavaProjects/bin/$1 ; #Tallenna käännetyt tiedostot tännei
mkdir -p classkansio/$1 ; # Luo class-tiedstoiselle kansio jos sitä ei ole vielä olemassa
cd /Users/tommi/JavaProjects/src/ ; # Vaihda kansioon, joka on yhtä ylempänä kuin paketti-kansio
start=$SECONDS ;
javac $1/$2.java ; #Käännä alkuperäinen tiedosto
kesto=$(( SECONDS - start )) ;
echo "Käännös tehty, aikaa meni $kesto sekuntia" ;
mv $1/*.class $classkansio ; # Siirrä class-loppuiset tiedostot niille varattuun kansioon
echo "Class-tiedostot siirretty kansion /Users/tommi/JavaProjects/bin/ alle, käynnistetään sovellus" ;
echo "----------------" ;
echo " " ;
java -cp "/Users/tommi/JavaProjects/bin" $1.$2
}

# Jos tiedosto on jo valmiina, niin tällä sen voi ajaa
# Bash-kielessä ei ole try-catch-mekanismia, joten tyydytään tähän
javarun(){
java -cp /Users/tommi/JavaProjects/bin $1.$2 || echo 'Valitettavasti haluamaasi tiedostoa ei ole. Jos asianmukainen Java-tiedosto ja paketti ovat olemassa, voit kääntää ja ajaa ne komennolla javacomp paketin_nimi tiedoston_nimi, minkä jälkeen voit käyttää ne tällä komennolla.' ;
}

# C++ kääntäjän asetukset
c++comp(){
g++ --std=c++17 $1.cpp -o $1
echo "Kääntäminen onnistui" ;
echo "-----------------------"
}

# Luo automaattisesti Python-ympäristöjä

condaenv(){
cd $HOME/Python ;
mkdir -p $1 ;
envfolder=$HOME/Python/$1 ; # Luo luodusta kansiosta alias
cd $envfolder ;
conda create --name "$@" ; # Luo ymoäristö
source activate $1 ; # Aktivoi ympäristö
mkdir -p etc/conda/activate.d ; # Luo kansio ympäristömuuttujille
mkdir -p etc/conda/deactivate.d ;
touch etc/conda/activate.d/env_vars.sh ; # Ymoäristömuuttujien tiedosto
touch etc/conda/deactivate.d/env_vars.sh ;
conda env export > environment.yaml; # Luo tiedosto, jotta conda_auto_env-funktio voisi toimia
}

# Funktio, jolla voi kytkeä automaattisesti conda-ympäristön päälle
# Copyright by Cory Schaefer
#------------------------------------------
# Modified from:
# https://github.com/chdoig/conda-auto-env

# Auto activate conda environments
function conda_auto_env() {
  if [ -e "environment.yaml" ]; then
    ENV_NAME=$(head -n 1 environment.yaml | cut -f2 -d ' ')
    # Check if you are already in the environment
    if [[ $CONDA_PREFIX != *$ENV_NAME* ]]; then
      # Try to activate environment
      source activate $ENV_NAME &>/dev/null
    fi
  fi
}

export PROMPT_COMMAND="conda_auto_env;$PROMPT_COMMAND"

export PATH="$HOME/.cargo/bin:$PATH"
