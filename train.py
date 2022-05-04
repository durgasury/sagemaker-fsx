# This is a dummy training script that simply lists files in your mount
# target, prints inside a for loop and saves a dummy model into EFS (and S3)
# Update this script to your model training script 
import argparse
import os
import sys
import time
import errno


def train(args):

    print('args', args)
    tmp = os.listdir(args.training_dir)
    print ('listing training files', tmp)

    # Run dummy training loop.
    epochs = 5
    for x in range(epochs):
        print("\nRunning epoch {0}...".format(x))
        time.sleep(2)
        print("Completed epoch {0}.".format(x))

    # At the end of the training loop, save model artifacts.
    model_filename = args.model_dir+"/model.dummy"
    os.makedirs(os.path.dirname(model_filename), exist_ok=True)
    with open(model_filename, "w") as f:
        f.write("Dummy model.")


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--model-dir", type=str, default=os.environ["SM_MODEL_DIR"])
    parser.add_argument("--checkpoint-dir", type=str, default="/opt/ml/checkpoints")
    parser.add_argument("--training-dir", type=str, default=os.environ["SM_CHANNEL_TRAIN"])
    
    args = parser.parse_args()

    train(args)