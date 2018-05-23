import numpy as np
import tensorflow as tf

n_observations = 100

xs = np.linspace(-3, 3, n_observations)
ys = np.sin(xs) + np.random.uniform(-0.5, 0.5, n_observations)

X = tf.placeholder(tf.float32, name='input_x')
Y = tf.placeholder(tf.float32)

W = tf.Variable(tf.constant(1.0), name='weight')
b = tf.Variable(tf.constant(2.0), name='bias')

Y_pred = tf.add(tf.multiply(X, W), b, 'target_add')

builder = tf.saved_model.builder.SavedModelBuilder('test_dir')

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    sess.run(Y_pred, feed_dict={X:xs})
    builder.add_meta_graph_and_variables(sess, ['test_graph'])

builder.save()



#cost = tf.reduce_sum(tf.pow(Y_pred - Y, 2)) / (n_observations - 1)

