import argparse
import os
import sys
import time


def train(args):

    print('args', args)
    
    tmp = os.listdir(args.training_dir)
    print ('listing training files', tmp)


    # Run training loop.
    epochs = 5
    for x in range(epochs):
        print("\nRunning epoch {0}...".format(x))

        time.sleep(2)

        print("Completed epoch {0}.".format(x))

    # At the end of the training loop, we have to save model artifacts.
    model_file = open(args.model_dir+"/model.dummy", "w")
    model_file.write('Dummy model.')
    model_file.close()


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--model-dir", type=str, default=os.environ["SM_MODEL_DIR"])
    
    parser.add_argument("--checkpoint-dir", type=str, default="/opt/ml/checkpoints")
    
    parser.add_argument("--training-dir", type=str, default=os.environ["SM_CHANNEL_TRAIN"])
    
    args = parser.parse_args()

    train(args)
