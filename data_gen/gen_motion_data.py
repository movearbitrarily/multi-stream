import os
import argparse
import numpy as np
from numpy.lib.format import open_memmap
from tqdm import tqdm
benchmarks = {
    'ntu': (
        # 'ntu/xview',
            'ntu/xsub',
            ),
    # 'ntu120': ('ntu120/xset', 'ntu120/xsub'),
    # 'kinetics': ('kinetics',)
}

parts = { 'train', 'val' }
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Bone data generation for NTU60/NTU120/Kinetics')
    parser.add_argument('--dataset', choices=['ntu', 'ntu120', 'kinetics'], required=True)
    # parser.add_argument('--kind', choices=['frame_trans', 'sequence_trans','neither'], required=True)
    args = parser.parse_args()

    for benchmark in benchmarks[args.dataset]:
        for part in parts:
        #     print(benchmark, part)
        #     try:
        #         data = np.load('../data/{}/{}_data_joint_seq.npy'.format(benchmark, part), mmap_mode='r')
        #         N, C, T, V, M = data.shape
        #         fp_sp = open_memmap(
        #             '../data/{}/{}_data_motion_seq.npy'.format(benchmark, part),
        #             dtype='float32',
        #             mode='w+',
        #             shape=(N, 3, T, V, M))
        #
        #         fp_sp[:, :, :, :, :] = np.zeros([N, 3, T, V, M])
        #         for i in range(T-1):
        #             fp_sp[:, :, i, :, :] = data[:,:,i+1,:,:] - data[:,:,i,:,:]
        #     except Exception as e:
        #         print(f'Run into error: {e}')
        #         print(f'Skipping ({benchmark} {part})')

            try:
                data = np.load('../data/{}/{}_data_bone.npy'.format(benchmark, part), mmap_mode='r')
                N, C, T, V, M = data.shape
                fp_sp = open_memmap(
                    '../data/{}/{}_data_bone_motion.npy'.format(benchmark, part),
                    dtype='float32',
                    mode='w+',
                    shape=(N, 3, T, V, M))
                fp_sp[:, :, :, :, :] = np.zeros([N, 3, T, V, M])
                for i in range(T - 1):
                    fp_sp[:, :, i, :, :] = data[:, :, i + 1, :, :] - data[:, :, i, :, :]
            except Exception as e:
                print(f'Run into error: {e}')
                print(f'Skipping ({benchmark} {part})')