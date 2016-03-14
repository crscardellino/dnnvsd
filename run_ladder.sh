#!/usr/bin/env bash

for i in 0 1 3 4 5 6 7 8 9 10 11 13 17 18 19 20 21 22 23 24 25 27 29 30 31 32 33 34 35 37 38 39 40 42 43 44 45 46 47 49 50 51 52 53 54 55 56 57 60 61 62 64 65 66 67 68 69 71 72 73 74 75 76 77 78 79 81 82 83 84 85 87 88 89 91 92 93 95 96 97 98 99 100 102 103 105 106 107 108 109 110 111 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 133 134 135 136 137 138 141 142 144 146 147 148 150 151 152 153 154 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 179 180 182 183 184 185 186 187 188 190 192 193 194 195 196 197 198 199 200 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 223 224 225 226 227 228 229 230 232 233 234 235 236 237 238 239 241 242 244 245 246 247 248
do
    idx=$(printf "%03d" $i)
    echo "================="
    echo "Running index $idx"
    echo "================="

    echo "Getting the data"
    scp crscardellino@172.18.0.249:Projects/dnnwsd/resources/corpus_datasets/es/7k/bow/${idx}.p /home/ccardellino/datasets/dataset_corpus/es/7k/bow/ &> /dev/null
    scp crscardellino@172.18.0.249:Projects/dnnwsd/resources/corpus_datasets/es/7k/vec/${idx}.p /home/ccardellino/datasets/dataset_corpus/es/7k/vec/ &> /dev/null
    scp crscardellino@172.18.0.249:Projects/dnnwsd/resources/corpus_datasets/es/7k/vecpos/${idx}.p /home/ccardellino/datasets/dataset_corpus/es/7k/vecpos/ &> /dev/null

    CUDA_VISIBLE_DEVICES=0 ./ladder.py $i

    echo "Deleting the data (to save space)"
    rm -f /home/crscardellino/datasets/dataset_corpus/es/7k/bow/${idx}.p
    rm -f /home/crscardellino/datasets/dataset_corpus/es/7k/vec/${idx}.p
    rm -f /home/crscardellino/datasets/dataset_corpus/es/7k/vecpos/${idx}.p

    echo "=================="
    echo "Finished index $idx"
    echo "=================="
    mv results/* resources/results/ladder/
done
