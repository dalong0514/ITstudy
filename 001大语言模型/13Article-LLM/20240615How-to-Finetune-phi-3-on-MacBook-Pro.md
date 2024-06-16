## 20240615How-to-Finetune-phi-3-on-MacBook-Pro

[How to Finetune phi-3 on MacBook Pro](https://huggingface.co/blog/abhishek/phi3-finetune-macbook)

[huggingface/autotrain-advanced: 🤗 AutoTrain Advanced](https://github.com/huggingface/autotrain-advanced)

[What is AutoTrain Advanced?](https://huggingface.co/docs/autotrain/index)

$ export HF_TOKEN=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

$ autotrain app --host 127.0.0.1 --port 10000


autotrain llm \
--train \
--model microsoft/Phi-3-mini-4k-instruct \
--data-path timdettmers/openassistant-guanaco \
--lr 2e-4 \
--batch-size 2 \
--epochs 1 \
--trainer sft \
--peft \
--project-name my-own-phi-3-on-mac \
--username dalong0514 \
--push-to-hub \
--token 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


Published April 24, 2024

Abhishek Thakur

In this blog, i'll show you how you can train/finetune the latest phi-3 model from Microsoft on your macbook pro! You'll need an M1 or M2 mac to do this. We will be using AutoTrain Advanced!

To install AutoTrain Advanced, you can do:

$ pip install autotrain-advanced

Note: autotrain doesnt install pytorch, torchvision etc. So, you need to install it yourself. You can create a conda environment and install these dependencies:

$ conda create -n autotrain python=3.10
$ conda activate autotrain
$ conda install pytorch::pytorch torchvision torchaudio -c pytorch
$ pip install autotrain-advanced

Once done, you can use the AutoTrain CLI or the UI on your mac machine! We will take a look at both!

AutoTrain not only offers LLM finetuning but many other tasks such as text classification, image classification, dreambooth lora, etc. But in this blog post, we are looking into LLM finetuning.

You can see all parameters you can adjust for llm finetuning by doing

$ autotrain llm --help

The next step is grabbing the data. In this blog I'm going to show you how you can train on your macbook with SFT training and ORPO tuning (the big but small brother of DPO).

For SFT training, we need a dataset with a single text column. We can use something like timdettmers/openassistant-guanaco or alpaca like datasets. Note: these datasets are already formatted as text with system prompt, user instruction and assistant message. If you have them in a format like the following:

[timdettmers/openassistant-guanaco · Datasets at Hugging Face](https://huggingface.co/datasets/timdettmers/openassistant-guanaco)

[ { "content": "Definition: In this task, you need to count the number of vowels (letters 'a', 'e', 'i', 'o', 'u') / consonants (all letters other than vowels) in the given sentence.\nInput: Sentence: 'a baseball player is in his hitting stance as a few people watch'. Count the number of consonants in the given sentence.\nOutput:", "role": "user" }, { "content": "32", "role": "assistant" } ]

you can use AutoTrain's chat-template parameter. We will see it later in this post, but for ORPO training. So, we will cover SFT training using pre-formatted dataset and do ORPO training with chat template.

For ORPO training, you can use a dataset like argilla/distilabel-capybara-dpo-7k-binarized. This dataset has many columns but we are interested only in chosen & rejected columns.

[argilla/distilabel-capybara-dpo-7k-binarized · Datasets at Hugging Face](https://huggingface.co/datasets/argilla/distilabel-capybara-dpo-7k-binarized)

With AutoTrain, only creating or finding the dataset will be the most time consuming part. Now, when we have the dataset, we can do a SFT training using:

autotrain llm \
--train \
--model microsoft/Phi-3-mini-4k-instruct \
--data-path timdettmers/openassistant-guanaco \
--lr 2e-4 \
--batch-size 2 \
--epochs 1 \
--trainer sft \
--peft \
--project-name my-own-phi-3-on-mac \
--username abhishek \
--push-to-hub \
--token $HF_TOKEN

Where $HF_TOKEN is your hugging face write token in case you want to push the trained model to hugging face hub for easy deployment and sharing. You can find your tokens here.

[Hugging Face – The AI community building the future.](https://huggingface.co/settings/tokens)

Note that, we are using lora and thats why we have the --peft parameter. Also, if the text column is not called text in your dataset, you can add another parameter --text-column your_datasets_text_column. In case you want to use your own CSV/JSON file instead of a hugging face hub dataset, you can call it train.csv / train.jsonl and place it in a local folder. Command to train will change slightly:

autotrain llm \
--train \
--model microsoft/Phi-3-mini-4k-instruct \
--data-path /path/to/folder/containing/training/file \
--text-column text_column_in_your_dataset \
--lr 2e-4 \
--batch-size 2 \
--epochs 1 \
--trainer sft \
--peft \
--project-name my-own-phi-3-on-mac \
--username abhishek \
--push-to-hub \
--token $HF_TOKEN

Next, we come to orpo training. For orpo training we change --trainer sft to --trainer orpo.

autotrain llm \
--train \
--model microsoft/Phi-3-mini-4k-instruct \
--data-path argilla/distilabel-capybara-dpo-7k-binarized \
--text-column chosen \
--rejected-text-column rejected \
--lr 2e-4 \
--batch-size 2 \
--epochs 1 \
--trainer orpo \
--chat-template chatml \
--peft \
--project-name my-own-phi-3-on-mac-orpo \
--username abhishek \
--push-to-hub \
--token $HF_TOKEN

There are 4 changes above. Its only the column mappings that have changed and the trainer and ofcourse, the dataset. One other major change is usage of --chat-template parameter which is set to chatml. For --chat-template, the choices are: zephyr, chatml, tokenizer or None. None is used if you already formatted the data properly yourself as we did in SFT training.

Now if CLI is too much for you, you can also use the UI! Which is even easier and allows you to upload files too.

To use the UI:

$ export HF_TOKEN=your_huggingface_write_token

$ autotrain app --host 127.0.0.1 --port 10000

Then go to http://127.0.0.1:10000 in your browser and enjoy AutoTrain UI! 🚀 A screenshot with same params as for ORPO training above is shown below:

If you are not able to find phi3 in the model dropdown list, you can use this URL instead: http://127.0.0.1:7860/?custom_models=microsoft/Phi-3-mini-4k-instruct. Note: I've added phi-3 as custom model. You can do the same for any other compatible model from the Hub. ;)

Both SFT and ORPO trainings were successfully tested on a M2 Max MacBook Pro.

In case of any issues or feature requests, use github repo.

P.S. An extensive documentation of AutoTrain can be found here

Happy (auto)training! 🚀
