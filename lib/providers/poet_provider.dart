import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kabyarphatyinhlu/Models/poet.dart';

final poetList = Provider(
  (ref) => [
    Poet(
      id: 1,
      // name: "ဆောင်ဦးသွင်",
      name: "Saung Oo Thwin",
      cover: "src/images/ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.png",
      description: "Saung Oo Thwin",
    ),
    Poet(
      id: 2,
      // name: "မိုးရဲ",
      name: "Moe Ye",
      cover: "src/images/နှုတ်မဆက်ခဲ့ရသူလေးသို့.png",
      description: "Moe Ye",
    ),
    Poet(
      id: 3,
      // name: "ရဲဘော်စည်သူ",
      name: "Ye Baw Si Thu",
      cover: "src/images/ကျန်ရစ်ခဲ့တော့မြိုင်.png",
      description: "Ye Baw Si Thu",
    ),
    Poet(
      id: 4,
      // name: "မောင်သိန်းဇော်",
      name: "Maung Thein Zaw",
      cover: "src/images/ပန်းကလေး.png",
      description: "Maung Thein Zaw",
    ),
    Poet(
      id: 5,
      // name: "စိုင်းဝင်းမြင့်",
      name: "Sai Win Myint",
      cover: "src/images/ကျေးဇူးတော်လမ်း.png",
      description: "Sai Win Myint",
    ),
    Poet(
      id: 6,
      // name: "ဆစ်ခ်",
      name: "Sikh",
      cover: "src/images/စိတ်အတွင်းသားထဲကမမ.png",
      description: "ဆစ်ခ်",
    ),
    Poet(
      id: 7,
      // name: "မြကျေး",
      name: "Mya Kyay",
      cover: "src/images/ချစ်မေတ္တာဝေအကြောင်း.png",
      description: "Mya Kyay",
    ),
    Poet(
      id: 8,
      // name: "စောဒိုစိုး",
      name: "Saw Do Soe",
      cover: "src/images/သူပုန်ဘဝ.png",
      description: "Saw Do Soe",
    ),
    Poet(
      id: 9,
      // name: "ရေနွေးအိုး",
      name: "Yay Nway O",
      cover: "src/images/လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.png",
      description: "Yay Nway O",
    ),
    Poet(
      id: 10,
      // name: "သန်းတင့်",
      name: "Than Tint",
      cover: "src/images/ခင်ဖုန်းသက်ဝေဖတ်ဖို့.png",
      description: "သန်းတင့်",
    ),
    Poet(
      id: 11,
      // name: "အောင်ခင်မြင့်",
      name: "Aung Khin Myint",
      cover: "src/images/တကယ်မရှိသောနှစ်များ.png",
      description: "Aung Khin Myint",
    ),
    Poet(
      id: 12,
      // name: "အောင်မူးဝေ",
      name: "Aung Muu Wai",
      cover: "src/images/ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ.png",
      description: "Aung Muu Wai",
    ),
    Poet(
      id: 13,
      // name: "ဇေယျာလင်း",
      name: "Zayar Lin",
      cover: "src/images/မင်းကိုကိုယ်ချစ်တယ်.png",
      description: "Zayar Lin",
    ),
    Poet(
      id: 14,
      // name: "တင်မိုး",
      name: "Tin Moe",
      cover: "src/images/အမေ့သားစကား.png",
      description: "Tin Moe",
    ),
    Poet(
      id: 15,
      // name: "ပါစီယွန်",
      name: "Parcyon",
      cover: "src/images/ရေပွက်ပမာ.png",
      description: "ပါစီယွန်",
    ),
    Poet(
      id: 15,
      // name: "ပါစီယွန်",
      name: "Percyon",
      cover: "src/images/ရေပွက်ပမာ.png",
      description: "Percyon",
    ),
    Poet(
      id: 16,
      // name: "မိုးဃ်းဇော်",
      name: "Moe Zaw",
      cover: "src/images/ဒေလီယာပန်းတွေပွင့်ပြီ.png",
      description: "Moe Zaw",
    ),
    Poet(
      id: 17,
      // name: "မောင်ချောနွယ်",
      name: "Maung Chaw Nwe",
      cover: "src/images/ကြယ်ပြာလေးနဲ့.png",
      description: "Maung Chaw Nwe",
    ),
    Poet(
      id: 18,
      // name: "မောင်ရေချမ်း",
      name: "Maung Yay Chan",
      cover: "src/images/ကျနော်ကခင်ဗျားကိုချစ်တယ်.png",
      description: "Maung Yay Chan",
    ),
    Poet(
      id: 19,
      // name: "မောင်သားစစ်",
      name: "Maung Thar Sit",
      cover: "src/images/အချစ်ဇာတ်လမ်း.png",
      description: "Maung Thar Sit",
    ),
    Poet(
      id: 20,
      // name: "ရွှေဘုန်းလူ",
      name: "Shwe Phone Lu",
      cover: "src/images/ကျောင်းဖွင့်ချိန်.png",
      description: "Shwe Phone Lu",
    ),
  ],
);

// final poetProvider = Provider<List<Poet>>((ref) {
//   final poets = ref.watch(poetList);

//   return poets;
// });
