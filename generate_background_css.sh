dir_path="assets/images/projects/mobile/*"
imagefiles=`find $dir_path -type f`

image_numbers=`find $dir_path -type f | wc -l`
floating_point_scale=5

animation_length_in_second=5
animation_overlap_length_in_second=1
animation_total_length_in_second=$(($animation_length_in_second * $image_numbers - $animation_overlap_length_in_second*($image_numbers-1)))
# 1秒が全体の何%に当たるか
animation_percent_by_second=`echo "scale=$floating_point_scale; 100.000 / $animation_total_length_in_second" | bc` 
animation_frames_in_per=`echo "scale=$floating_point_scale; 100.000 / $image_numbers" | bc` 

loop_count=0


for imagefilepath in $imagefiles;
do
    # file path
    imagefilename=`echo $imagefilepath | cut -d '/' -f 5`
    imagefilenameprefix=`echo $imagefilename | cut -d '.' -f 1`

    # set animation time
    animation_start_time=`echo "scale=$floating_point_scale; $loop_count * $animation_frames_in_per" | bc`
    animation_end_time=`echo "scale=$floating_point_scale; ($loop_count+1) * $animation_frames_in_per" | bc`
    animation_middle_time=`echo "scale=$floating_point_scale; ($animation_start_time + $animation_end_time)/2" |bc`

    animation_start_time_in_second=$(($loop_count * ($animation_length_in_second-$animation_overlap_length_in_second)))
    animation_end_time_in_second=$((($loop_count+1) * $animation_length_in_second - $loop_count * $animation_overlap_length_in_second))

    animation_start_time=`echo "scale=$floating_point_scale; $animation_start_time_in_second * $animation_percent_by_second" | bc`
    animation_end_time=`echo "scale=$floating_point_scale; $animation_end_time_in_second * $animation_percent_by_second " | bc`
    animation_middle_time=`echo "scale=$floating_point_scale; ($animation_start_time + $animation_end_time)/2" |bc`
    
    # echo "starttime "$animation_start_time
    # echo "middletime "$animation_middle_time
    # echo "endtime "$animation_end_time

    css_string="\n
    @keyframes animation-$imagefilenameprefix {\n
        \t 0% {opacity: 0; }\n
        \t $animation_start_time% {opacity: 0; }\n
        \t $animation_middle_time% {opacity: 1; }\n
        \t $animation_end_time% {opacity: 0; }\n
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
        \t animation: animation-$imagefilenameprefix $animation_total_length_in_second"s" ease-out infinite;\n
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

    loop_count=$(($loop_count+1))
done

