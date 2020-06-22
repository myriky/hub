#!/bin/sh

DATE=$(date +%Y%m%d%H%M) 
IMAGE_SIZE=224

# MODULE=https://tfhub.dev/google/imagenet/mobilenet_v1_100_224/feature_vector/4
MODULE=https://tfhub.dev/google/imagenet/mobilenet_v2_130_224/classification/3

SHELL_PATH=`pwd -P`

PYTHONWARNINGS="ignore"

echo $SHELL_PATH

echo $MODULE

echo "============ begin ML trainning ============"

mkdir "$SHELL_PATH/tf_files/output/$DATE"

if python3 examples/image_retraining/retrain.py \
  --image_dir=tf_files/dataset \
  --tfhub_module=$MODULE \
  --bottleneck_dir=tf_files/bottlenecks \
  --summaries_dir=tf_files/training_summaries \
  --intermediate_output_graphs_dir=tf_files/intermediate_graphs \
  --intermediate_store_frequency=500 \
  --output_graph=tf_files/output/$DATE/retrained_graph.pb \
  --output_labels=tf_files/output/$DATE/retrained_labels.txt \
  --saved_model_dir=tf_files/output/$DATE/saved_model \
  --how_many_training_steps=10000 \
  --learning_rate=0.005 \
  --testing_percentage=1
  # --flip_left_right True \
  # --testing_percentage=5 \
  # --validation_percentage=20 \
  # --random_scale=30 \
  # --random_brightness=30 \
  # --how_many_training_steps=10000 \
  # --learning_rate=0.005
then
  echo "============ re-train completed ============"
else
  echo ERROR:
  exit 1
fi


# python3 examples/image_retraining/retrain.py \
#   --image_dir=tf_files/dataset \
#   --tfhub_module=$MODULE \
#   --output_graph=$SHELL_PATH/tf_files/output/$DATE/retrained_graph.pb \
#   --bottleneck_dir=$SHELL_PATH/tf_files/bottlenecks \
#   --summaries_dir=$SHELL_PATH/tf_files/training_summaries \
#   --intermediate_output_graphs_dir=$SHELL_PATH/tf_files/intermediate_graphs \
#   --intermediate_store_frequency=500 \
#   --saved_model_dir=$SHELL_PATH/tf_files/output/$DATE/saved_model \
#   --output_labels=$SHELL_PATH/tf_files/output/$DATE/retrained_labels.txt \
#   --how_many_training_steps=100 \
#   # --how_many_training_steps=2000 \
#   --learning_rate=0.0333


echo "============ check begin 1 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample1.jpg
then
  echo "============ check completed 1 ============"
else
  echo ERROR:
  exit 1
fi

echo "============ check begin 2 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample2.jpg
then
  echo "============ check completed 2 ============"
else
  echo ERROR:
  exit 1
fi

echo "============ check begin 3 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample3.jpg
then
  echo "============ check completed 3 ============"
else
  echo ERROR:
  exit 1
fi


echo "============ check begin 4 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample4.jpg
then
  echo "============ check completed 4 ============"
else
  echo ERROR:
  exit 1
fi


echo "============ check begin 5 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample5.jpg
then
  echo "============ check completed 5 ============"
else
  echo ERROR:
  exit 1
fi


echo "============ check begin 6 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample6.jpg
then
  echo "============ check completed 6 ============"
else
  echo ERROR:
  exit 1
fi

echo "============ check begin 7 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample7.jpg
then
  echo "============ check completed 7 ============"
else
  echo ERROR:
  exit 1
fi

echo "============ check begin 8 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample8.jpg
then
  echo "============ check completed 8 ============"
else
  echo ERROR:
  exit 1
fi


echo "============ check begin 9 ============"

if python3 label_image.py \
  --graph=tf_files/output/$DATE/retrained_graph.pb \
  --input_width=$IMAGE_SIZE \
  --input_height=$IMAGE_SIZE \
  --input_layer=Placeholder \
  --labels=tf_files/output/$DATE/retrained_labels.txt \
  --image=sample/sample9.jpg
then
  echo "============ check completed 9 ============"
else
  echo ERROR:
  exit 1
fi




echo "============ quantize begin  ============"
if python3 quantize_graph.py \
  --input=tf_files/output/$DATE/retrained_graph.pb \
  --output=tf_files/output/$DATE/quantized_graph.pb \
  --output_node_names=final_result \
  --mode=weights_rounded
then
  echo "============ quantize completed ============"
else
  echo ERROR:
  exit 1
fi



echo "============ converting begin ============"

if tensorflowjs_converter \
  --input_format=tf_frozen_model \
  --output_node_names=final_result \
  tf_files/output/$DATE/quantized_graph.pb \
  tf_files/output/$DATE/tf_js
then
  echo "============ converting completed ============"
else
  echo ERROR:
  exit 1
fi


echo "============ make label ============"

if node publish.js tf_files/output/$DATE/retrained_labels.txt tf_files/output/$DATE/tf_js/boricha_classes-$DATE.js
then
  echo "============ make label completed ============"
  cat tf_files/output/$DATE/tf_js/boricha_classes-$DATE.js
else
  echo ERROR:
  exit 1
fi


echo "============ sync model to S3 ============"

if aws s3 sync tf_files/output/$DATE/tf_js/ s3://boricha-classifier/model/$DATE --exclude "*.DS_Store*" --acl public-read
then
  echo "============ sync model to S3 completed ============"
else
  echo ERROR:
  exit 1
fi


echo "============ update version ============"

if echo $DATE > VERSION
then
  echo "============ update version completed ============"
else
  echo ERROR:
  exit 1
fi

echo "============ sync version file ============"

if aws s3 cp VERSION s3://boricha-classifier/ --acl public-read
then
  echo "============ sync version file completed ============"
else
  echo ERROR:
  exit 1
fi

echo $DATE

open tf_files/output/$DATE/tf_js/

echo "============ COMPLETED :) ============"

