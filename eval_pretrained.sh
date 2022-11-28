## Generate test scores

# NTU 60 XSub
python main.py --config ./config/nturgbd-cross-subject/test_joint.yaml --work-dir pretrain_eval/ntu60/xsub/joint-fusion --weights pretrained-models/ntu60-xsub-joint-fusion.pt
python main.py --config ./config/nturgbd-cross-subject/test_bone.yaml --work-dir pretrain_eval/ntu60/xsub/bone --weights pretrained-models/ntu60-xsub-bone.pt
python main.py --config config/nturgbd-cross-subject/test_joint_S_trans.yaml --work-dir pretrain_eval/ntu60/xsub/joint-seq --weights pretrained-models/ntu60-xsub-joint-seq.pt
python main.py --config config/nturgbd-cross-subject/test_bone_S_trans.yaml --work-dir pretrain_eval/ntu60/xsub/bone-seq --weights pretrained-models/ntu60-xsub-bone-seq.pt
#
# NTU 60 XView
python main.py --config ./config/nturgbd-cross-view/test_joint.yaml --work-dir pretrain_eval/ntu60/xview/joint --weights pretrained-models/ntu60-xview-joint.pt
python main.py --config ./config/nturgbd-cross-view/test_bone.yaml --work-dir pretrain_eval/ntu60/xview/bone --weights pretrained-models/ntu60-xview-bone.pt
python main.py --config config/nturgbd-cross-view/test_bone_S_trans.yaml --work-dir pretrain_eval/ntu60/xview/bone-seq --weights pretrained-models/ntu60-xview-bone-seq.pt
python main.py --config config/nturgbd-cross-view/test_joint_S_trans.yaml --work-dir pretrain_eval/ntu60/xview/joint-seq --weights pretrained-models/ntu60-xview-joint-seq.pt

# NTU 120 XSub
python main.py --config ./config/nturgbd120-cross-subject/test_joint.yaml --work-dir pretrain_eval/ntu120/xsub/joint --weights pretrained-models/ntu120-xsub-joint.pt
python main.py --config ./config/nturgbd120-cross-subject/test_bone.yaml --work-dir pretrain_eval/ntu120/xsub/bone --weights pretrained-models/ntu120-xsub-bone.pt
python main.py --config config/nturgbd120-cross-subject/test_bone_S_trans.yaml --work-dir pretrain_eval/ntu120/xsub/bone-seq --weights pretrained-models/ntu120-xsub-bone-seq.pt
python main.py --config config/nturgbd120-cross-subject/test_joint_S_trans.yaml --work-dir pretrain_eval/ntu120/xsub/joint-seq --weights pretrained-models/ntu120-xsub-joint-seq.pt

# NTU 120 XSet
python main.py --config ./config/nturgbd120-cross-setup/test_joint.yaml --work-dir pretrain_eval/ntu120/xset/joint --weights pretrained-models/ntu120-xset-joint.pt
python main.py --config ./config/nturgbd120-cross-setup/test_bone.yaml --work-dir pretrain_eval/ntu120/xset/bone --weights pretrained-models/ntu120-xset-bone.pt
python main.py --config config/nturgbd120-cross-setup/test_bone_S_trans.yaml --work-dir pretrain_eval/ntu120/xset/bone-seq --weights pretrained-models/ntu120-xset-bone-seq.pt
python main.py --config config/nturgbd120-cross-setup/test_joint_S_trans.yaml --work-dir pretrain_eval/ntu120/xset/joint-seq --weights pretrained-models/ntu120-xset-joint-seq.pt

#NW UCLA
python main.py --config ./config/ucla/test_joint.yaml --work-dir pretrain_eval/ncla/joint --weights pretrained-models/ncla-joint.pt
python main.py --config ./config/ucla/test_bone.yaml --work-dir pretrain_eval/ncla/bone --weights pretrained-models/ncla-bone.pt
python main.py --config ./config/ucla/test_bone_frame.yaml --work-dir pretrain_eval/ncla/bone-frame --weights pretrained-models/ncla-bone-frame.pt
python main.py --config ./config/ucla/test_joint_frame.yaml --work-dir pretrain_eval/ncla/joint-frame --weights pretrained-models/ncla-joint-frame.pt


# Perform all ensembles at once

# NTU 60 XSub
printf "\nNTU RGB+D 60 XSub\n"
python ensemble.py --val-path ./data/ntu/xsub/val_label.pkl \
--one pretrain_eval/ntu60/xsub/joint-fusion \
--two  pretrain_eval/ntu60/xsub/bone \
--three  pretrain_eval/ntu60/xsub/joint-seq \
--four  pretrain_eval/ntu60/xsub/bone-seq \
# NTU 60 XView
printf "\nNTU RGB+D 60 XView\n"
python ensemble.py --val-path ./data/ntu/xview/val_label.pkl \
--one pretrain_eval/ntu60/xview/joint \
--two  pretrain_eval/ntu60/xview/bone \
--three  pretrain_eval/ntu60/xview/joint-seq \
--four  pretrain_eval/ntu60/xview/bone-seq \
# NTU 120 XSub
printf "\nNTU RGB+D 120 XSub\n"
python ensemble.py --val-path ./data/ntu120/xsub/val_label.pkl \
--one pretrain_eval/ntu120/xsub/joint \
--two  pretrain_eval/ntu120/xsub/bone \
--three  pretrain_eval/ntu120/xsub/joint-seq \
--four  pretrain_eval/ntu120/xsub/bone-seq \
# NTU 120 XSet
printf "\nNTU RGB+D 120 XSet\n"
python ensemble.py --val-path ./data/ntu120/xset/val_label.pkl \
--one pretrain_eval/ntu120/xset/joint \
--two  pretrain_eval/ntu120/xset/bone \
--three  pretrain_eval/ntu120/xset/joint-seq \
--four  pretrain_eval/ntu120/xset/bone-seq \


#NW-UCLA
python ensemble.py --val-path ./data/NW-UCLA/val_label.pkl \
--one pretrain_eval/ncla/joint \
--two  pretrain_eval/ncla/bone \
--three  pretrain_eval/ncla/joint_frame \
--four  pretrain_eval/ncla/bone_frame
