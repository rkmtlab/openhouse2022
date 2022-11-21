dir_path="assets/images/projects/mobile/*"
mobile_image_files=`find $dir_path -type f`

image_numbers=`find $dir_path -type f | wc -l`
floating_point_scale=5
loop_count=0

# 1枚の画像が出てから消えるまでの時間
animation_length_in_second=6
# どれぐらいオーバーラップするか
animation_overlap_length_in_second=3
# アニメーション全体での時間
animation_total_length_in_second=$(($animation_length_in_second * $image_numbers - $animation_overlap_length_in_second*($image_numbers-1)))
# 1秒が全体の何%に当たるか
animation_percent_by_second=`echo "scale=$floating_point_scale; 100.000 / $animation_total_length_in_second" | bc` 


for mobile_image_file_path in $mobile_image_files;
do
    # file path
    image_file_name=`echo $mobile_image_file_path | cut -d '/' -f 5`
    image_file_name_prefix=`echo $image_file_name | cut -d '.' -f 1`
    desktop_image_file_path=`echo $mobile_image_file_path | sed -e s/"mobile\/"//`

    # set animation time
    animation_start_time_in_second=$(($loop_count * ($animation_length_in_second-$animation_overlap_length_in_second)))
    animation_end_time_in_second=$((($loop_count+1) * $animation_length_in_second - $loop_count * $animation_overlap_length_in_second))

    animation_start_time=`echo "scale=$floating_point_scale; $animation_start_time_in_second * $animation_percent_by_second" | bc`
    animation_end_time=`echo "scale=$floating_point_scale; $animation_end_time_in_second * $animation_percent_by_second " | bc`
    animation_middle_time=`echo "scale=$floating_point_scale; ($animation_start_time + $animation_end_time)/2" |bc`

    css_string="\n
    @keyframes animation-$image_file_name_prefix {\n
        \t 0% {opacity: 0; }\n
        \t $animation_start_time% {opacity: 0; }\n
        \t $animation_middle_time% {opacity: 1; }\n
        \t $animation_end_time% {opacity: 0; }\n
        \t 100% {opacity: 0; } \n
    }\n
    .bg-container #bg-$image_file_name_prefix {\n
        \t z-index: −2;\n
        \t position: fixed;\n
        \t left: 0;\n
        \t top: 0;\n
        \t right: 0;\n
        \t bottom: 0;\n
        \t min-width: 100%;\n
        \t min-height: 100%;\n
        \t background: no-repeat center center;\n
        \t animation: animation-$image_file_name_prefix $animation_total_length_in_second"s" ease-out infinite;\n
        }\n
    @media screen and (min-width: 500px) {\n
        \t     .bg-container #bg-$image_file_name_prefix {\n
        \t     background-image: url(../$desktop_image_file_path);\n
        \t     background-size: 100% auto; } \n
    }\n
    @media screen and (max-width: 500px) {\n
        \t     .bg-container #bg-$image_file_name_prefix {\n
        \t     background-image: url(../$mobile_image_file_path);\n
        \t     background-size: 100% auto; } \n
    }\n"

    # ここからCSSを出力する
    echo $css_string

    # 下のコメントアウトを解除するとindex.htmlに出力するものが出てくる
    # echo "<div id=\"bg-$image_file_name_prefix\"></div>"

    loop_count=$(($loop_count+1))
done

