import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/Models/poet.dart';

final playlistProviderTest = Provider(
  (ref) => [
    // Music(
    //   id: 1,
    //   title: "Ghost",
    //   artist: "Justin B",
    //   path: "ghost.mp3",
    //   cover: "src/images/Justice_Explicit.webp",
    //   poet_id: 1,
    //   poet: Poet(
    //       id: 1,
    //       name: "Justin B",
    //       cover: "src/images/Justice_Explicit.webp",
    //       description: "Justin B"),
    // ),
    // Music(
    //   id: 2,
    //   title: "Let Me Down Slowly",
    //   artist: "Alec Benjamin",
    //   path: "Alec Benjamin - Let Me Down Slowly.mp3",
    //   cover: "src/images/Justice_Explicit.webp",
    //   poet_id: 2,
    //   poet: Poet(
    //       id: 1,
    //       name: "Justin B",
    //       cover: "src/images/Justice_Explicit.webp",
    //       description: "Justin B"),
    // ),
    // Music(
    //   id: 3,
    //   title: "Let Me Down Slowly",
    //   artist: "Alec Benjamin",
    //   path: "Alec Benjamin - Let Me Down Slowly.mp3",
    //   cover: "src/images/Justice_Explicit.webp",
    //   poet_id: 1,
    //   poet: Poet(
    //       id: 1,
    //       name: "Alec Benjami",
    //       cover: "src/images/Justice_Explicit.webp",
    //       description: "Justin B"),
    // ),
    Music(
      id: 1,
      title: "ကဗျာဆရာနှင့် ပတ်သက်ဖူးသော",
      artist: "ဆောင်းဦးသွင်",
      cover: "src/images/ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.png",
      path: "ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.mp3",
      poet_id: 1,
      poet: Poet(
        id: 1,
        name: "ဆောင်းဦးသွင်",
        cover: "ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.png",
        description: "ဆောင်းဦးသွင်",
      ),
    ),
    Music(
      id: 2,
      title: "နှုတ်မဆက်ခဲ့ရသူလေးသို့",
      artist: "မိုးရဲ",
      cover: "src/images/နှုတ်မဆက်ခဲ့ရသူလေးသို့.png",
      path: "နှုတ်မဆက်ခဲ့ရသူလေးသို့.mp3",
      poet_id: 2,
      poet: Poet(
        id: 2,
        name: "မိုးရဲ",
        cover: "နှုတ်မဆက်ခဲ့ရသူလေးသို့.png",
        description: "မိုးရဲ",
      ),
    ),
    Music(
      id: 3,
      title: "ကျန်ရစ်ခဲ့တော့မြိုင်",
      artist: "ရဲဘော်စည်သူ",
      path: "ကျန်ရစ်ခဲ့တော့မြိုင်.mp3",
      cover: "src/images/ကျန်ရစ်ခဲ့တော့မြိုင်.png",
      poet_id: 3,
    ),
    Music(
      id: 4,
      title: "ပန်းကလေး",
      artist: "မောင်သိန်းဇော်",
      path: "ပန်းကလေး.mp3",
      cover: "src/images/ပန်းကလေး.png",
      poet_id: 4,
    ),
    Music(
      id: 5,
      title: "ကျေးဇူးတော်လမ်း",
      artist: "စိုင်းဝင်းမြင့်",
      path: "ကျေးဇူးတော်လမ်း.mp3",
      cover: "src/images/ကျေးဇူးတော်လမ်း.png",
      poet_id: 5,
    ),
    Music(
      id: 6,
      title: "ငါချစ်ရင်ပိုပိုချစ်",
      artist: "စိုင်းဝင်းမြင့်",
      path: "ငါချစ်ရင်ပိုပိုချစ်.mp3",
      cover: "src/images/ငါချစ်ရင်ပိုပိုချစ်.png",
      poet_id: 5,
    ),
    Music(
      id: 7,
      title: "မိသားစု",
      artist: "စိုင်းဝင်းမြင့်",
      path: "မိသားစု.mp3",
      cover: "src/images/မိသားစု.png",
      poet_id: 5,
    ),
    Music(
      id: 8,
      title: "အရေးအသားတစ်ခု",
      artist: "စိုင်းဝင်းမြင့်",
      path: "အရေးအသားတစ်ခု.mp3",
      cover: "src/images/အရေးအသားတစ်ခု.png",
      poet_id: 5,
    ),
    Music(
      id: 9,
      title: "သေနေတဲ့အပင်ကိုရှင်အောင်စိုက်တယ်",
      artist: "စိုင်းဝင်းမြင့်",
      path: "သေနေတဲ့အပင်.mp3",
      cover: "src/images/သေနေတဲ့အပင်.png",
      poet_id: 5,
    ),
    Music(
      id: 10,
      title: "စိတ်အတွင်းသားထဲက...နှင်းဆီဝါ (သို့မဟုတ်) မမ",
      artist: "ဆစ်ခ်",
      path: "စိတ်အတွင်းသားထဲကမမ.mp3",
      cover: "src/images/စိတ်အတွင်းသားထဲကမမ.png",
      poet_id: 6,
    ),
    Music(
      id: 11,
      title: "မင်းကိုပြောပြချင်ပြီးပြောပြလို့မရတဲ့ကိစ္စတွေ",
      artist: "ဆစ်ခ်",
      path: "မင်းကိုပြောပြ.mp3",
      cover: "src/images/မင်းကိုပြောပြ.png",
      poet_id: 6,
    ),
    Music(
      id: 12,
      title: "ချစ်မေတ္တာဝေအကြောင်း",
      artist: "မြကျေး",
      path: "ချစ်မေတ္တာဝေအကြောင်း.mp3",
      cover: "src/images/ချစ်မေတ္တာဝေအကြောင်း.png",
      poet_id: 7,
    ),
    Music(
      id: 13,
      title: "အနည်းဆုံးအနေနဲ့ကျွန်မကိုသတိရစေချင်တယ်",
      artist: "မြကျေး",
      path: "အနည်းဆုံးအနေနဲ့.mp3",
      cover: "src/images/အနည်းဆုံးအနေနဲ့.png",
      poet_id: 7,
    ),
    Music(
      id: 14,
      title: "ဂျွန်ကပြောတယ်အားလုံးမြစ်ဆီသို့",
      artist: "မောင်သိန်းဇော်",
      path: "ဂျွန်ကပြောတယ်.mp3",
      cover: "src/images/ဂျွန်ကပြောတယ်.png",
      poet_id: 4,
    ),
    Music(
      id: 15,
      title: "သူပုန်ဘဝ",
      artist: "စောဒိုစိုး",
      path: "သူပုန်ဘဝ.mp3",
      cover: "src/images/သူပုန်ဘဝ.png",
      poet_id: 8,
    ),
    Music(
      id: 16,
      title: "လူယုတ်မာကြီးဖြစ်ချင်တယ် အမေ",
      artist: "ရေနွေးအိုး",
      path: "လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.mp3",
      cover: "src/images/လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.png",
      poet_id: 9,
    ),
    Music(
      id: 17,
      title: "အနုပညာသူပုန်",
      artist: "ရေနွေးအိုး",
      path: "အနုပညာသူပုန်.mp3",
      cover: "src/images/အနုပညာသူပုန်.png",
      poet_id: 9,
    ),
    Music(
      id: 18,
      title: "ခင်ဖုန်းသက်ဝေဖတ်ဖို့နွေ",
      artist: "သန်းတင့်",
      path: "ခင်ဖုန်းသက်တွေဖတ်ဖို့.mp3",
      cover: "src/images/ခင်ဖုန်းသက်ဝေဖတ်ဖို့.png",
      poet_id: 10,
    ),
    Music(
      id: 19,
      title: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ",
      artist: "သန်းတင့်",
      path: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ.mp3",
      cover: "src/images/ခင်ဖုန်းသက်ဝေဂယ်လာရီ.png",
      poet_id: 10,
    ),
    Music(
      id: 20,
      title: "တကယ်မရှိသောနှစ်များ",
      artist: "အောင်ခင်မြင့်",
      path: "တကယ်မရှိသောနှစ်.mp3",
      cover: "src/images/တကယ်မရှိသောနှစ်များ.png",
      poet_id: 11,
    ),
    Music(
      id: 21,
      title: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်",
      artist: "အောင်ခင်မြင့်",
      path: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.mp3",
      cover: "src/images/ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.png",
      poet_id: 11,
    ),
    Music(
      id: 22,
      title: "ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ",
      artist: "အောင်မူးဝေ",
      path: "ကွန်မြူနစ်ကလေး.mp3",
      cover: "src/images/ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ.png",
      poet_id: 12,
    ),
    Music(
      id: 23,
      title: "မိခါးချို",
      artist: "အောင်မူးဝေ",
      path: "မိခါးချို.mp3",
      cover: "src/images/မိခါးချို.png",
      poet_id: 12,
    ),
    Music(
      id: 24,
      title: "မင်းကိုကိုယ်ချစ်တယ်",
      artist: "ဇေယျာလင်း",
      path: "မင်းကိုကိုယ်ချစ်တယ်.mp3",
      cover: "src/images/မင်းကိုကိုယ်ချစ်တယ်.png",
      poet_id: 13,
    ),
    Music(
      id: 25,
      title: "အမေ့သားစကားတိုးတိုး ပြောလှည့်ပါ",
      artist: "ဇေယျာလင်း",
      path: "အမေ့သားစကား.mp3",
      cover: "src/images/အမေ့သားစကား.png",
      poet_id: 14,
    ),
    Music(
      id: 26,
      title: "ရေပွက်ပမာ",
      artist: "ပါစီယွန်",
      path: "ရေပွက်ပမာ.mp3",
      cover: "src/images/ရေပွက်ပမာ.png",
      poet_id: 15,
    ),
    Music(
      id: 27,
      title: "ဒေလီယာပန်းတွေပွင့်ပြီ",
      artist: "မိုးဃ်းဇော်",
      path: "ဒေလီယာပန်းတွေပွင့်ပြီ.mp3",
      cover: "src/images/ဒေလီယာပန်းတွေပွင့်ပြီ.png",
      poet_id: 16,
    ),
    Music(
      id: 28,
      title: "ကြယ်ပြာလေးနဲ့ထမင်းစားပြီးနောက်",
      artist: "မောင်ချောနွယ်",
      path: "ကြယ်ပြာလေးနဲ့.mp3",
      cover: "src/images/ကြယ်ပြာလေးနဲ့.png",
      poet_id: 17,
    ),

    Music(
      id: 29,
      title: "ကျနော်က ခင်ဗျားကို ချစ်တယ်ပြောတဲ့ အချိန်",
      artist: "မောင်ရေချမ်း",
      path: "ကျနော်ကခင်ဗျားကိုချစ်တယ်.mp3",
      cover: "src/images/ကျနော်ကခင်ဗျားကိုချစ်တယ်.png",
      poet_id: 18,
    ),
    Music(
      id: 30,
      title: "အချစ်ဇာတ်လမ်း",
      artist: "မောင်သားစစ်",
      path: "အချစ်ဇာတ်လမ်း.mp3",
      cover: "src/images/အချစ်ဇာတ်လမ်း.png",
      poet_id: 19,
    ),
    Music(
      id: 31,
      title: "ကျောင်းဖွင့်ချိန်",
      artist: "ရွှေဘုန်းလူ",
      path: "ကျောင်းဖွင့်ချိန်.mp3",
      cover: "src/images/ကျောင်းဖွင့်ချိန်.png",
      poet_id: 20,
    ),
  ],
);

final playlistProvider =
    StateNotifierProvider<PlaylistStateNotifier, AsyncValue<List<Music>>>(
  ((ref) {
    return PlaylistStateNotifier();
  }),
);

class PlaylistStateNotifier extends StateNotifier<AsyncValue<List<Music>>> {
  List<Music> playlist = [
    Music(
      id: 1,
      title: "ကဗျာဆရာနှင့် ပတ်သက်ဖူးသော",
      artist: "ဆောင်းဦးသွင်",
      cover: "src/images/ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.png",
      path: "ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.mp3",
      poet_id: 1,
    ),
    Music(
      id: 2,
      title: "နှုတ်မဆက်ခဲ့ရသူလေးသို့",
      artist: "မိုးရဲ",
      cover: "src/images/နှုတ်မဆက်ခဲ့ရသူလေးသို့.png",
      path: "နှုတ်မဆက်ခဲ့ရသူလေးသို့.mp3",
      poet_id: 2,
    ),
    Music(
      id: 3,
      title: "ကျန်ရစ်ခဲ့တော့မြိုင်",
      artist: "ရဲဘော်စည်သူ",
      path: "ကျန်ရစ်ခဲ့တော့မြိုင်.mp3",
      cover: "src/images/ကျန်ရစ်ခဲ့တော့မြိုင်.png",
      poet_id: 3,
    ),
    Music(
      id: 4,
      title: "ပန်းကလေး",
      artist: "မောင်သိန်းဇော်",
      path: "ပန်းကလေး.mp3",
      cover: "src/images/ပန်းကလေး.png",
      poet_id: 4,
    ),
    Music(
      id: 5,
      title: "ကျေးဇူးတော်လမ်း",
      artist: "စိုင်းဝင်းမြင့်",
      path: "ကျေးဇူးတော်လမ်း.mp3",
      cover: "src/images/ကျေးဇူးတော်လမ်း.png",
      poet_id: 5,
    ),
    Music(
      id: 6,
      title: "ငါချစ်ရင်ပိုပိုချစ်",
      artist: "စိုင်းဝင်းမြင့်",
      path: "ငါချစ်ရင်ပိုပိုချစ်.mp3",
      cover: "src/images/ငါချစ်ရင်ပိုပိုချစ်.png",
      poet_id: 5,
    ),
    Music(
      id: 7,
      title: "မိသားစု",
      artist: "စိုင်းဝင်းမြင့်",
      path: "မိသားစု.mp3",
      cover: "src/images/မိသားစု.png",
      poet_id: 5,
    ),
    Music(
      id: 8,
      title: "အရေးအသားတစ်ခု",
      artist: "စိုင်းဝင်းမြင့်",
      path: "အရေးအသားတစ်ခု.mp3",
      cover: "src/images/အရေးအသားတစ်ခု.png",
      poet_id: 5,
    ),
    Music(
      id: 9,
      title: "သေနေတဲ့အပင်ကိုရှင်အောင်စိုက်တယ်",
      artist: "စိုင်းဝင်းမြင့်",
      path: "သေနေတဲ့အပင်.mp3",
      cover: "src/images/သေနေတဲ့အပင်.png",
      poet_id: 5,
    ),
    Music(
      id: 10,
      title: "စိတ်အတွင်းသားထဲက...နှင်းဆီဝါ (သို့မဟုတ်) မမ",
      artist: "ဆစ်ခ်",
      path: "စိတ်အတွင်းသားထဲကမမ.mp3",
      cover: "src/images/စိတ်အတွင်းသားထဲကမမ.png",
      poet_id: 6,
    ),
    Music(
      id: 11,
      title: "မင်းကိုပြောပြချင်ပြီးပြောပြလို့မရတဲ့ကိစ္စတွေ",
      artist: "ဆစ်ခ်",
      path: "မင်းကိုပြောပြ.mp3",
      cover: "src/images/မင်းကိုပြောပြ.png",
      poet_id: 6,
    ),
    Music(
      id: 12,
      title: "ချစ်မေတ္တာဝေအကြောင်း",
      artist: "မြကျေး",
      path: "ချစ်မေတ္တာဝေအကြောင်း.mp3",
      cover: "src/images/ချစ်မေတ္တာဝေအကြောင်း.png",
      poet_id: 7,
    ),
    Music(
      id: 13,
      title: "အနည်းဆုံးအနေနဲ့ကျွန်မကိုသတိရစေချင်တယ်",
      artist: "မြကျေး",
      path: "အနည်းဆုံးအနေနဲ့.mp3",
      cover: "src/images/အနည်းဆုံးအနေနဲ့.png",
      poet_id: 7,
    ),
    Music(
      id: 14,
      title: "ဂျွန်ကပြောတယ်အားလုံးမြစ်ဆီသို့",
      artist: "မောင်သိန်းဇော်",
      path: "ဂျွန်ကပြောတယ်.mp3",
      cover: "src/images/ဂျွန်ကပြောတယ်.png",
      poet_id: 4,
    ),
    Music(
      id: 15,
      title: "သူပုန်ဘဝ",
      artist: "စောဒိုစိုး",
      path: "သူပုန်ဘဝ.mp3",
      cover: "src/images/သူပုန်ဘဝ.png",
      poet_id: 8,
    ),
    Music(
      id: 16,
      title: "လူယုတ်မာကြီးဖြစ်ချင်တယ် အမေ",
      artist: "ရေနွေးအိုး",
      path: "လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.mp3",
      cover: "src/images/လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.png",
      poet_id: 9,
    ),
    Music(
      id: 17,
      title: "အနုပညာသူပုန်",
      artist: "ရေနွေးအိုး",
      path: "အနုပညာသူပုန်.mp3",
      cover: "src/images/အနုပညာသူပုန်.png",
      poet_id: 9,
    ),
    Music(
      id: 18,
      title: "ခင်ဖုန်းသက်ဝေဖတ်ဖို့နွေ",
      artist: "သန်းတင့်",
      path: "ခင်ဖုန်းသက်တွေဖတ်ဖို့.mp3",
      cover: "src/images/ခင်ဖုန်းသက်ဝေဖတ်ဖို့.png",
      poet_id: 10,
    ),
    Music(
      id: 19,
      title: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ",
      artist: "သန်းတင့်",
      path: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ.mp3",
      cover: "src/images/ခင်ဖုန်းသက်ဝေဂယ်လာရီ.png",
      poet_id: 10,
    ),
    Music(
      id: 20,
      title: "တကယ်မရှိသောနှစ်များ",
      artist: "အောင်ခင်မြင့်",
      path: "တကယ်မရှိသောနှစ်.mp3",
      cover: "src/images/တကယ်မရှိသောနှစ်များ.png",
      poet_id: 11,
    ),
    Music(
      id: 21,
      title: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်",
      artist: "အောင်ခင်မြင့်",
      path: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.mp3",
      cover: "src/images/ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.png",
      poet_id: 11,
    ),
    Music(
      id: 22,
      title: "ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ",
      artist: "အောင်မူးဝေ",
      path: "ကွန်မြူနစ်ကလေး.mp3",
      cover: "src/images/ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ.png",
      poet_id: 12,
    ),
    Music(
      id: 23,
      title: "မိခါးချို",
      artist: "အောင်မူးဝေ",
      path: "မိခါးချို.mp3",
      cover: "src/images/မိခါးချို.png",
      poet_id: 12,
    ),
    Music(
      id: 24,
      title: "မင်းကိုကိုယ်ချစ်တယ်",
      artist: "ဇေယျာလင်း",
      path: "မင်းကိုကိုယ်ချစ်တယ်.mp3",
      cover: "src/images/မင်းကိုကိုယ်ချစ်တယ်.png",
      poet_id: 13,
    ),
    Music(
      id: 25,
      title: "အမေ့သားစကားတိုးတိုး ပြောလှည့်ပါ",
      artist: "ဇေယျာလင်း",
      path: "အမေ့သားစကား.mp3",
      cover: "src/images/အမေ့သားစကား.png",
      poet_id: 14,
    ),
    Music(
      id: 26,
      title: "ရေပွက်ပမာ",
      artist: "ပါစီယွန်",
      path: "ရေပွက်ပမာ.mp3",
      cover: "src/images/ရေပွက်ပမာ.png",
      poet_id: 15,
    ),
    Music(
      id: 27,
      title: "ဒေလီယာပန်းတွေပွင့်ပြီ",
      artist: "မိုးဃ်းဇော်",
      path: "ဒေလီယာပန်းတွေပွင့်ပြီ.mp3",
      cover: "src/images/ဒေလီယာပန်းတွေပွင့်ပြီ.png",
      poet_id: 16,
    ),
    Music(
      id: 28,
      title: "ကြယ်ပြာလေးနဲ့ထမင်းစားပြီးနောက်",
      artist: "မောင်ချောနွယ်",
      path: "ကြယ်ပြာလေးနဲ့.mp3",
      cover: "src/images/ကြယ်ပြာလေးနဲ့.png",
      poet_id: 17,
    ),
    Music(
      id: 29,
      title: "ကျနော်က ခင်ဗျားကို ချစ်တယ်ပြောတဲ့ အချိန်",
      artist: "မောင်ရေချမ်း",
      path: "ကျနော်ကခင်ဗျားကိုချစ်တယ်.mp3",
      cover: "src/images/ကျနော်ကခင်ဗျားကိုချစ်တယ်.png",
      poet_id: 18,
    ),
    Music(
      id: 30,
      title: "အချစ်ဇာတ်လမ်း",
      artist: "မောင်သားစစ်",
      path: "အချစ်ဇာတ်လမ်း.mp3",
      cover: "src/images/အချစ်ဇာတ်လမ်း.png",
      poet_id: 19,
    ),
    Music(
      id: 31,
      title: "ကျောင်းဖွင့်ချိန်",
      artist: "ရွှေဘုန်းလူ",
      path: "ကျောင်းဖွင့်ချိန်.mp3",
      cover: "src/images/ကျောင်းဖွင့်ချိန်.png",
      poet_id: 20,
    ),
  ];
  PlaylistStateNotifier() : super(const AsyncValue.loading()) {
    state = AsyncData(playlist);
  }

  void add(Music music) {
    if (state.asData != null) {
      if (!state.asData!.value.contains(music)) {
        state = AsyncData([...state.asData!.value, music]);
      }
    }
  }

  void addAll(List<Music> playlist) {
    // skip existing music
    if (state.asData != null) {
      for (var music in playlist) {
        if (!state.asData!.value.contains(music)) {
          state = AsyncData([...state.asData!.value, music]);
        }
      }
    }
  }

  void remove(Music music) {
    // state.remove(music);
  }
}

final audioPlayerProvider = Provider.autoDispose<AudioPlayer>((ref) {
  final playlist = ref.watch(playlistProvider);
  final audioPlayer = AudioPlayer();

  if (playlist.asData != null) {
    audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: [
          for (var music in playlist.asData!.value)
            AudioSource.uri(
              Uri.parse('asset:///src/poems/${music.path}'),
              tag: Music(
                id: music.id,
                title: music.title,
                artist: music.artist,
                path: music.path,
                cover: music.cover,
                poet_id: music.poet_id,
                poet: music.poet,
              ),
            ),
        ],
      ),
    )
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }
  // default loop mode to all

  return audioPlayer;
});

final audioPlayerState = StreamProvider.autoDispose<PlayerState>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  final playerState = audioPlayer.playerStateStream;

  return playerState;
});

final currentPositionStream = StreamProvider.autoDispose<Duration>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.positionStream;
});

final loopStream = StreamProvider.autoDispose<LoopMode>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.loopModeStream;
});

final currentMusicIndex = StreamProvider.autoDispose<int?>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.currentIndexStream;
});

final currentSequenceStream = StreamProvider.autoDispose((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);

  return audioPlayer.sequenceStateStream;
});
