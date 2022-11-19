dir_path="assets/images/projects/mobile/*"
imagefiles=`find $dir_path -type f`

css_result=""


for imagefilepath in $imagefiles;
do
    # echo $imagefilepath
    imagefilename=`echo $imagefilepath | cut -d '/' -f 5`
    imagefilenameprefix=`echo $imagefilename | cut -d '.' -f 1`
    # echo $imagefilenameprefix

    css_string="\n
    @keyframes animation-$imagefilenameprefix {\n
        \t 0% {opacity: 0; }\n
        \t 57.14286% {opacity: 0; }\n
        \t 71.42857% {opacity: 1; }\n
        \t 85.71429% {opacity: 0; }\n
        \t 100% {opacity: 0; } \n
    }\n
    .bg-container #bg-$imagefilenameprefix {\n
        \t z-index: −2;\n
        \t position: fixed;\n
        \t left: 0;\n
        \t top: 0;\n
        \t right: 0;\n
        \t bottom: 0;\n
        \t min-width: 100%;\n
        \t min-height: 100%;\n
        \t background: no-repeat center center;\n
        \t animation: animation-$imagefilenameprefix 35s ease-out infinite;\n
        }\n
    @media screen and (min-width: 500px) {\n
        \t     .bg-container #bg-$imagefilenameprefix {\n
        \t     background-image: url(../$imagefilepath);\n
        \t     background-size: 100% auto; } \n
    }\n
    @media screen and (max-width: 500px) {\n
        \t     .bg-container #bg-$imagefilenameprefix {\n
        \t     background-image: url(../$imagefilepath);\n
        \t     background-size: auto 100%; } \n
    }\n"
    echo $css_string
    # echo "<div id=\"bg-$imagefilenameprefix\"></div>"

done

