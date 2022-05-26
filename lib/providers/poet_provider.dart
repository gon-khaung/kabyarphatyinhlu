import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kabyarphatyinhlu/Models/poet.dart';

final poetList = Provider(
  (ref) => [
    Poet(
      id: 1,
      name: "ဆောင်ဦးသွင်",
      cover: "src/images/ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.png",
      description: "This is Aung Aung",
    ),
    Poet(
      id: 2,
      name: "မိုးရဲ",
      cover: "src/images/နှုတ်မဆက်ခဲ့ရသူလေးသို့.png",
      description: "မိုးရဲ",
    ),
    Poet(
      id: 3,
      name: "ရဲဘော်စည်သူ",
      cover: "src/images/ကျန်ရစ်ခဲ့တော့မြိုင်.png",
      description: "ရဲဘော်စည်သူ",
    ),
    Poet(
      id: 4,
      name: "မောင်သိန်းဇော်",
      cover: "src/images/ပန်းကလေး.png",
      description: "မောင်သိန်းဇော်",
    ),
    Poet(
      id: 5,
      name: "စိုင်းဝင်းမြင့်",
      cover: "src/images/ကျေးဇူးတော်လမ်း.png",
      description: "စိုင်းဝင်းမြင့်",
    ),
    Poet(
      id: 6,
      name: "ဆစ်ခ်",
      cover: "src/images/စိတ်အတွင်းသားထဲကမမ.png",
      description: "ဆစ်ခ်",
    ),
    Poet(
      id: 7,
      name: "မြကျေး",
      cover: "src/images/ချစ်မေတ္တာဝေအကြောင်း.png",
      description: "မြကျေး",
    ),
    Poet(
      id: 8,
      name: "စောဒိုစိုး",
      cover: "src/images/သူပုန်ဘဝ.png",
      description: "စောဒိုစိုး",
    ),
    Poet(
      id: 9,
      name: "ရေနွေးအိုး",
      cover: "src/images/လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.png",
      description: "ရေနွေးအိုး",
    ),
    Poet(
      id: 10,
      name: "သန်းတင့်",
      cover: "src/images/ခင်ဖုန်းသက်ဝေဖတ်ဖို့.png",
      description: "သန်းတင့်",
    ),
    Poet(
      id: 11,
      name: "အောင်ခင်မြင့်",
      cover: "src/images/တကယ်မရှိသောနှစ်များ.png",
      description: "အောင်ခင်မြင့်",
    ),
    Poet(
      id: 12,
      name: "အောင်မူးဝေ",
      cover: "src/images/ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ.png",
      description: "အောင်မူးဝေ",
    ),
    Poet(
      id: 13,
      name: "ဇေယျာလင်း",
      cover: "src/images/မင်းကိုကိုယ်ချစ်တယ်.png",
      description: "ဇေယျာလင်း",
    ),
    Poet(
      id: 14,
      name: "တင်မိုး",
      cover: "src/images/အမေ့သားစကား.png",
      description: "တင်မိုး",
    ),
    Poet(
      id: 15,
      name: "ပါစီယွန်",
      cover: "src/images/ရေပွက်ပမာ.png",
      description: "ပါစီယွန်",
    ),
    Poet(
      id: 15,
      name: "ပါစီယွန်",
      cover: "src/images/ရေပွက်ပမာ.png",
      description: "ပါစီယွန်",
    ),
    Poet(
      id: 16,
      name: "မိုးဃ်းဇော်",
      cover: "src/images/ဒေလီယာပန်းတွေပွင့်ပြီ.png",
      description: "မိုးဃ်းဇော်",
    ),
    Poet(
      id: 17,
      name: "မောင်ချောနွယ်",
      cover: "src/images/ကြယ်ပြာလေးနဲ့.png",
      description: "မောင်ချောနွယ်",
    ),
    Poet(
      id: 18,
      name: "မောင်ရေချမ်း",
      cover: "src/images/ကျနော်ကခင်ဗျားကိုချစ်တယ်.png",
      description: "မောင်ရေချမ်း",
    ),
    Poet(
      id: 19,
      name: "မောင်သားစစ်",
      cover: "src/images/အချစ်ဇာတ်လမ်း.png",
      description: "မောင်သားစစ်",
    ),
    Poet(
      id: 20,
      name: "ရွှေဘုန်းလူ",
      cover: "src/images/ကျောင်းဖွင့်ချိန်.png",
      description: "ရွှေဘုန်းလူ",
    ),
  ],
);

// final poetProvider = Provider<List<Poet>>((ref) {
//   final poets = ref.watch(poetList);

//   return poets;
// });
