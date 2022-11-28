import argparse
import pickle
import os

import numpy as np
from tqdm import tqdm

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--val-path',
                        help="Directory containing \"val_label.pkl\" eg ./data/ntu/xsub/val_label.pkl")
    parser.add_argument('--one',
                        help='Directory containing "epoch1_test_score.pkl" for joint eval results')
    parser.add_argument('--two',default=None,
                        help='Directory containing "epoch1_test_score.pkl" for bone eval results')
    parser.add_argument('--three',default=None,
                        help='Directory containing "epoch1_test_score.pkl" for bone eval results')
    parser.add_argument('--four',default=None,
                        help='Directory containing "epoch1_test_score.pkl" for bone eval results')


    arg = parser.parse_args()

    val_path = arg.val_path
    if 'NW-UCLA' in val_path:
        label = []
        with open('./data/' + 'NW-UCLA/' + '/val_label.pkl', 'rb') as f:
            data_info = pickle.load(f)
            for index in range(len(data_info)):
                info = data_info[index]
                label.append(int(info['label']) - 1)
    else:
        with open(val_path, 'rb') as label:
            label = np.array(pickle.load(label))
            label = list(zip(label[0],label[1].astype(int)))

    with open(os.path.join(arg.one, 'epoch1_test_score.pkl'), 'rb') as r1:
        r1 = list(pickle.load(r1).items())
    with open(os.path.join(arg.two, 'epoch1_test_score.pkl'), 'rb') as r2:
        r2 = list(pickle.load(r2).items())
    with open(os.path.join(arg.three, 'epoch1_test_score.pkl'), 'rb') as r3:
        r3 = list(pickle.load(r3).items())
    with open(os.path.join(arg.four, 'epoch1_test_score.pkl'), 'rb') as r4:
        r4 = list(pickle.load(r4).items())



    label.sort(key=lambda i: i[0])
    r1.sort(key=lambda i: i[0])
    r2.sort(key=lambda i: i[0])
    r3.sort(key=lambda i: i[0])
    r4.sort(key=lambda i: i[0])


    right_num = total_num = right_num_5 = 0
    for i in tqdm(range(len(label))):
            name, l = label[i]
            _, r11 = r1[i]
            _, r22 = r2[i]
            _, r33 = r3[i]
            _, r44 = r4[i]


            r = (r11 + r22) + (r33 +r44)
            rank_5 = r.argsort()[-5:]
            right_num_5 += int(int(l) in rank_5)
            r = np.argmax(r)
            right_num += int(r == int(l))
            total_num += 1
    acc = right_num / total_num
    acc5 = right_num_5 / total_num
    print('Top1 Acc: {:.4f}%'.format(acc * 100))
    print('Top5 Acc: {:.4f}%'.format(acc5 * 100))


