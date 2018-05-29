import numpy as np
import tensorflow as tf

size = 32
channel = 3

kernel_size = 5
conv_out_channel = 1

v_input = np.full([1, size, size, channel], 1.0, dtype=np.float32)

input = tf.placeholder(dtype=tf.float32, shape=[None, size, size, channel], name='input')
filter = tf.Variable(tf.constant(1.0, dtype=tf.float32, shape=[kernel_size, kernel_size, channel, conv_out_channel]), name='filter')

conv = tf.nn.conv2d(input, filter, strides=[1, 2, 2, 1], padding='SAME', name='conv')

bias = tf.Variable(tf.constant(1.0, dtype=tf.float32, shape=[size/2, size/2, conv_out_channel]), name='bias')

relu = tf.nn.relu(conv + bias, name='relu')

builder = tf.saved_model.builder.SavedModelBuilder('test_model_conv')

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    vout = sess.run(relu, feed_dict={input:v_input})
    print(vout)
    builder.add_meta_graph_and_variables(sess, ['test_model_conv'])

builder.save()


#cost = tf.reduce_sum(tf.pow(Y_pred - Y, 2)) / (n_observations - 1)

