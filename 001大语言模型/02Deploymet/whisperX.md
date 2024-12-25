### 01. 信息资源

[m-bain/whisperX: WhisperX: Automatic Speech Recognition with Word-level Timestamps (& Diarization)](https://github.com/m-bain/whisperX?tab=readme-ov-file)

### 02. 运行跑的记录

目前没跑通。（2024-12-24）

whisperx /Users/Daglas/Desktop/output.wav  --model large-v3 --diarize --highlight_words True --output_dir /Users/Daglas/Desktop --output_format json --batch_size 4 --language en --compute_type int8



whisperx -h

/Users/Daglas/miniconda3/envs/whisper/lib/python3.10/site-packages/pyannote/audio/core/io.py:43: UserWarning: torchaudio._backend.set_audio_backend has been deprecated. With dispatcher enabled, this function is no-op. You can remove the function call.
  torchaudio.set_audio_backend("soundfile")
usage: whisperx [-h] [--model MODEL] [--model_dir MODEL_DIR] [--device DEVICE] [--device_index DEVICE_INDEX] [--batch_size BATCH_SIZE] [--compute_type {float16,float32,int8}]
                [--output_dir OUTPUT_DIR] [--output_format {all,srt,vtt,txt,tsv,json,aud}] [--verbose VERBOSE] [--task {transcribe,translate}]
                [--language {af,am,ar,as,az,ba,be,bg,bn,bo,br,bs,ca,cs,cy,da,de,el,en,es,et,eu,fa,fi,fo,fr,gl,gu,ha,haw,he,hi,hr,ht,hu,hy,id,is,it,ja,jw,ka,kk,km,kn,ko,la,lb,ln,lo,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,my,ne,nl,nn,no,oc,pa,pl,ps,pt,ro,ru,sa,sd,si,sk,sl,sn,so,sq,sr,su,sv,sw,ta,te,tg,th,tk,tl,tr,tt,uk,ur,uz,vi,yi,yo,yue,zh,Afrikaans,Albanian,Amharic,Arabic,Armenian,Assamese,Azerbaijani,Bashkir,Basque,Belarusian,Bengali,Bosnian,Breton,Bulgarian,Burmese,Cantonese,Castilian,Catalan,Chinese,Croatian,Czech,Danish,Dutch,English,Estonian,Faroese,Finnish,Flemish,French,Galician,Georgian,German,Greek,Gujarati,Haitian,Haitian Creole,Hausa,Hawaiian,Hebrew,Hindi,Hungarian,Icelandic,Indonesian,Italian,Japanese,Javanese,Kannada,Kazakh,Khmer,Korean,Lao,Latin,Latvian,Letzeburgesch,Lingala,Lithuanian,Luxembourgish,Macedonian,Malagasy,Malay,Malayalam,Maltese,Maori,Marathi,Moldavian,Moldovan,Mongolian,Myanmar,Nepali,Norwegian,Nynorsk,Occitan,Panjabi,Pashto,Persian,Polish,Portuguese,Punjabi,Pushto,Romanian,Russian,Sanskrit,Serbian,Shona,Sindhi,Sinhala,Sinhalese,Slovak,Slovenian,Somali,Spanish,Sundanese,Swahili,Swedish,Tagalog,Tajik,Tamil,Tatar,Telugu,Thai,Tibetan,Turkish,Turkmen,Ukrainian,Urdu,Uzbek,Valencian,Vietnamese,Welsh,Yiddish,Yoruba}]
                [--align_model ALIGN_MODEL] [--interpolate_method {nearest,linear,ignore}] [--no_align] [--return_char_alignments] [--vad_onset VAD_ONSET]
                [--vad_offset VAD_OFFSET] [--chunk_size CHUNK_SIZE] [--diarize] [--min_speakers MIN_SPEAKERS] [--max_speakers MAX_SPEAKERS] [--temperature TEMPERATURE]
                [--best_of BEST_OF] [--beam_size BEAM_SIZE] [--patience PATIENCE] [--length_penalty LENGTH_PENALTY] [--suppress_tokens SUPPRESS_TOKENS] [--suppress_numerals]
                [--initial_prompt INITIAL_PROMPT] [--condition_on_previous_text CONDITION_ON_PREVIOUS_TEXT] [--fp16 FP16]
                [--temperature_increment_on_fallback TEMPERATURE_INCREMENT_ON_FALLBACK] [--compression_ratio_threshold COMPRESSION_RATIO_THRESHOLD]
                [--logprob_threshold LOGPROB_THRESHOLD] [--no_speech_threshold NO_SPEECH_THRESHOLD] [--max_line_width MAX_LINE_WIDTH] [--max_line_count MAX_LINE_COUNT]
                [--highlight_words HIGHLIGHT_WORDS] [--segment_resolution {sentence,chunk}] [--threads THREADS] [--hf_token HF_TOKEN] [--print_progress PRINT_PROGRESS]
                audio [audio ...]

positional arguments:
  audio                 audio file(s) to transcribe

options:
  -h, --help            show this help message and exit
  --model MODEL         name of the Whisper model to use (default: small)
  --model_dir MODEL_DIR
                        the path to save model files; uses ~/.cache/whisper by default (default: None)
  --device DEVICE       device to use for PyTorch inference (default: cpu)
  --device_index DEVICE_INDEX
                        device index to use for FasterWhisper inference (default: 0)
  --batch_size BATCH_SIZE
                        the preferred batch size for inference (default: 8)
  --compute_type {float16,float32,int8}
                        compute type for computation (default: float16)
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        directory to save the outputs (default: .)
  --output_format {all,srt,vtt,txt,tsv,json,aud}, -f {all,srt,vtt,txt,tsv,json,aud}
                        format of the output file; if not specified, all available formats will be produced (default: all)
  --verbose VERBOSE     whether to print out the progress and debug messages (default: True)
  --task {transcribe,translate}
                        whether to perform X->X speech recognition ('transcribe') or X->English translation ('translate') (default: transcribe)
  --language {af,am,ar,as,az,ba,be,bg,bn,bo,br,bs,ca,cs,cy,da,de,el,en,es,et,eu,fa,fi,fo,fr,gl,gu,ha,haw,he,hi,hr,ht,hu,hy,id,is,it,ja,jw,ka,kk,km,kn,ko,la,lb,ln,lo,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,my,ne,nl,nn,no,oc,pa,pl,ps,pt,ro,ru,sa,sd,si,sk,sl,sn,so,sq,sr,su,sv,sw,ta,te,tg,th,tk,tl,tr,tt,uk,ur,uz,vi,yi,yo,yue,zh,Afrikaans,Albanian,Amharic,Arabic,Armenian,Assamese,Azerbaijani,Bashkir,Basque,Belarusian,Bengali,Bosnian,Breton,Bulgarian,Burmese,Cantonese,Castilian,Catalan,Chinese,Croatian,Czech,Danish,Dutch,English,Estonian,Faroese,Finnish,Flemish,French,Galician,Georgian,German,Greek,Gujarati,Haitian,Haitian Creole,Hausa,Hawaiian,Hebrew,Hindi,Hungarian,Icelandic,Indonesian,Italian,Japanese,Javanese,Kannada,Kazakh,Khmer,Korean,Lao,Latin,Latvian,Letzeburgesch,Lingala,Lithuanian,Luxembourgish,Macedonian,Malagasy,Malay,Malayalam,Maltese,Maori,Marathi,Moldavian,Moldovan,Mongolian,Myanmar,Nepali,Norwegian,Nynorsk,Occitan,Panjabi,Pashto,Persian,Polish,Portuguese,Punjabi,Pushto,Romanian,Russian,Sanskrit,Serbian,Shona,Sindhi,Sinhala,Sinhalese,Slovak,Slovenian,Somali,Spanish,Sundanese,Swahili,Swedish,Tagalog,Tajik,Tamil,Tatar,Telugu,Thai,Tibetan,Turkish,Turkmen,Ukrainian,Urdu,Uzbek,Valencian,Vietnamese,Welsh,Yiddish,Yoruba}
                        language spoken in the audio, specify None to perform language detection (default: None)
  --align_model ALIGN_MODEL
                        Name of phoneme-level ASR model to do alignment (default: None)
  --interpolate_method {nearest,linear,ignore}
                        For word .srt, method to assign timestamps to non-aligned words, or merge them into neighbouring. (default: nearest)
  --no_align            Do not perform phoneme alignment (default: False)
  --return_char_alignments
                        Return character-level alignments in the output json file (default: False)
  --vad_onset VAD_ONSET
                        Onset threshold for VAD (see pyannote.audio), reduce this if speech is not being detected (default: 0.5)
  --vad_offset VAD_OFFSET
                        Offset threshold for VAD (see pyannote.audio), reduce this if speech is not being detected. (default: 0.363)
  --chunk_size CHUNK_SIZE
                        Chunk size for merging VAD segments. Default is 30, reduce this if the chunk is too long. (default: 30)
  --diarize             Apply diarization to assign speaker labels to each segment/word (default: False)
  --min_speakers MIN_SPEAKERS
                        Minimum number of speakers to in audio file (default: None)
  --max_speakers MAX_SPEAKERS
                        Maximum number of speakers to in audio file (default: None)
  --temperature TEMPERATURE
                        temperature to use for sampling (default: 0)
  --best_of BEST_OF     number of candidates when sampling with non-zero temperature (default: 5)
  --beam_size BEAM_SIZE
                        number of beams in beam search, only applicable when temperature is zero (default: 5)
  --patience PATIENCE   optional patience value to use in beam decoding, as in https://arxiv.org/abs/2204.05424, the default (1.0) is equivalent to conventional beam search
                        (default: 1.0)
  --length_penalty LENGTH_PENALTY
                        optional token length penalty coefficient (alpha) as in https://arxiv.org/abs/1609.08144, uses simple length normalization by default (default: 1.0)
  --suppress_tokens SUPPRESS_TOKENS
                        comma-separated list of token ids to suppress during sampling; '-1' will suppress most special characters except common punctuations (default: -1)
  --suppress_numerals   whether to suppress numeric symbols and currency symbols during sampling, since wav2vec2 cannot align them correctly (default: False)
  --initial_prompt INITIAL_PROMPT
                        optional text to provide as a prompt for the first window. (default: None)
  --condition_on_previous_text CONDITION_ON_PREVIOUS_TEXT
                        if True, provide the previous output of the model as a prompt for the next window; disabling may make the text inconsistent across windows, but the model
                        becomes less prone to getting stuck in a failure loop (default: False)
  --fp16 FP16           whether to perform inference in fp16; True by default (default: True)
  --temperature_increment_on_fallback TEMPERATURE_INCREMENT_ON_FALLBACK
                        temperature to increase when falling back when the decoding fails to meet either of the thresholds below (default: 0.2)
  --compression_ratio_threshold COMPRESSION_RATIO_THRESHOLD
                        if the gzip compression ratio is higher than this value, treat the decoding as failed (default: 2.4)
  --logprob_threshold LOGPROB_THRESHOLD
                        if the average log probability is lower than this value, treat the decoding as failed (default: -1.0)
  --no_speech_threshold NO_SPEECH_THRESHOLD
                        if the probability of the <|nospeech|> token is higher than this value AND the decoding has failed due to `logprob_threshold`, consider the segment as
                        silence (default: 0.6)
  --max_line_width MAX_LINE_WIDTH
                        (not possible with --no_align) the maximum number of characters in a line before breaking the line (default: None)
  --max_line_count MAX_LINE_COUNT
                        (not possible with --no_align) the maximum number of lines in a segment (default: None)
  --highlight_words HIGHLIGHT_WORDS
                        (not possible with --no_align) underline each word as it is spoken in srt and vtt (default: False)
  --segment_resolution {sentence,chunk}
                        (not possible with --no_align) the maximum number of characters in a line before breaking the line (default: sentence)
  --threads THREADS     number of threads used by torch for CPU inference; supercedes MKL_NUM_THREADS/OMP_NUM_THREADS (default: 0)
  --hf_token HF_TOKEN   Hugging Face Access Token to access PyAnnote gated models (default: None)
  --print_progress PRINT_PROGRESS
                        if True, progress will be printed in transcribe() and align() methods. (default: False)

### 03. 安装部署记录

虚拟环境 whisper。

### 03. 问题汇总

2024-12-24



