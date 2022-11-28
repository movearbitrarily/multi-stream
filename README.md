# Multi-Channel Network: Constructing Efficient GCN Baselines for Skeleton-based Action Recognition
## Dependencies

- Python == 3.8.5
- torch== 1.7.1
- apex==0.1

## Data Preparation

*Disk usage warning: after preprocessing, the total sizes of datasets are around  77G,  157GB, 63GB for NTU RGB+D 60, NTU RGB+D 120, and Kinetics 400, respectively. The raw/intermediate sizes may be larger.*

### Download Datasets

There are 3 datasets to download:

- NTU RGB+D 60 Skeleton
- NTU RGB+D 120 Skeleton

#### NTU RGB+D 60 and 120

1. Request dataset here: http://rose1.ntu.edu.sg/Datasets/actionRecognition.asp

2. Download the skeleton-only datasets:
    - `nturgbd_skeletons_s001_to_s017.zip`  (NTU RGB+D 60)
    - `nturgbd_skeletons_s018_to_s032.zip`  (NTU RGB+D 120, on top of NTU RGB+D 60)
    - Total size should be 5.8GB + 4.5GB.

3. Download missing skeletons lookup files [from the authors' GitHub repo](https://github.com/shahroudy/NTURGB-D#samples-with-missing-skeletons):
    - NTU RGB+D 60 Missing Skeletons:
      `wget https://raw.githubusercontent.com/shahroudy/NTURGB-D/master/Matlab/NTU_RGBD_samples_with_missing_skeletons.txt`

    - NTU RGB+D 120 Missing Skeletons:
      `wget https://raw.githubusercontent.com/shahroudy/NTURGB-D/master/Matlab/NTU_RGBD120_samples_with_missing_skeletons.txt`

    - Remember to remove the first few lines of text in these files!
#### NW-UCLA

1. Download dataset from [here](https://www.dropbox.com/s/10pcm4pksjy6mkq/all_sqe.zip?dl=0)
2. Move `all_sqe` to `./data/NW-UCLA`


### Data Preprocessing

#### Directory Structure

Put downloaded data into the following directory structure:

```
- data/
  - nturgbd_raw/
    - nturgb+d_skeletons/     # from `nturgbd_skeletons_s001_to_s017.zip`
      ...
    - nturgb+d_skeletons120/  # from `nturgbd_skeletons_s001_to_s017.zip``nturgbd_skeletons_s018_to_s032.zip`
      ...
    - NTU_RGBD_samples_with_missing_skeletons.txt
    - NTU_RGBD120_samples_with_missing_skeletons.txt
```

#### Generating Data

+ Run bash  gene_data.sh

## Pretrained Models

- Download pretrained models for producing the final results on NTU RGB+D 60, NTU RGB+D 120, NW-ucla: 

  [Google Drive](https://drive.google.com/drive/folders/1BIFtSgBuJU0B1igz0nDAVcdnIOwhztXO?usp=sharing)


- Put the folder of pretrained models at repo root:

```
- multi-stream/
  - pretrained-models/
  - main.py
  - ...
```

- Run `bash eval_pretrained.sh`


## Training & Testing

- The general training template command:
```
python3 main.py
  --config <config file>
  --work-dir <place to keep things (weights, checkpoints, logs)>
```

- The general testing template command:
```
python3 main.py
  --config <config file>
  --work-dir <place to keep things>
  --weights <path to model weights>
```

- Template for stream fusion:
```
python3 ensemble.py
  --dataset <val_label path> \
  --one   <work_dir of your test command for frame-level joint model> \
  --two   <work_dir of your test command for frame-level bone model> \
  --three  <work_dir of your test command for sequence-level joint model> \
  --four  <work_dir of your test command for sequence-level bone model> \
```

- Use the corresponding config files from `./config` to train/test different datasets

  

## Acknowledgements

This repo is based on

- [MS-G3D](https://github.com/kenziyuliu/MS-G3D)
- [2s-AGCN](https://github.com/lshiwjx/2s-AGCN)
- [ST-GCN](https://github.com/yysijie/st-gcn)

Thanks to the original authors for their work!
