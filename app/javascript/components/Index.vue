<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner(color="primary" size="7em" :thickness="10")
    div(v-else)
      div(v-if="error")
        p Error!
      div(v-else)
        div
          q-carousel(
          animated
          v-model="slide"
          navigation
          infinite
          :autoplay="5000"
          arrows
          height="300px"
          transition-prev="slide-right"
          transition-next="slide-left")
            q-carousel-slide(:name="1" img-src="https://miro.medium.com/max/2800/0*jYTPhSdLKCzrRSxb.jpg")
              div(class="absolute-bottom slider")
                div(class="text-h4") Тот, кто не читает хороших книг, не имеет преимуществ перед человеком, который не умеет читать их.
                div(class="text-subtitle1") Марк Твен
            q-carousel-slide(:name="2" img-src="https://video-images.vice.com/articles/5d44c9622980b0000824a7e3/lede/1564789576071-GettyImages-949118068.jpeg?crop=1xw%3A0.8419xh%3B0xw%2C0.1581xh&resize=2000%3A*")
              div(class="absolute-bottom slider")
                div(class="text-h4") Всё, что я знаю о своей жизни, мне кажется, я вычитал из книг.
                div(class="text-subtitle1") Жан-Поль Сартр

          q-toolbar(class="bg-grey-3")
            q-toolbar-title(align="middle") Новинки
          div(class="q-pa-md row items-start q-gutter-md")
            q-card(class="card")
              q-img(src="https://cv8.litres.ru/pub/c/elektronnaya-kniga/cover_415/4239285--.jpg")
                div(class="absolute-bottom title-book text-subtitle2\n") Семь навыков высокоэффективных людей
              q-card-section(class="text-caption text-grey")
                | Во-первых, эта книга излагает системный подход к определению жизненных целей, приоритетов человека. Эти цели у всех разные, но книга помогает понять себя и четко сформулиров....
            q-card(class="card")
              q-img(src="https://cv3.litres.ru/pub/c/elektronnaya-kniga/cover_415/50331636-oskar-hartmann-prosto-delay-delay-prosto.jpg")
                div(class="absolute-bottom title-book text-subtitle2\n") Семь навыков высокоэффективных людей
              q-card-section(class="text-caption")
                | Во-первых, эта книга излагает системный подход к определению жизненных целей, приоритетов человека. Эти цели у всех разные, но книга помогает понять себя и четко сформулиров....
            q-card(class="card")
              q-img(src="https://cv1.litres.ru/pub/c/elektronnaya-kniga/cover_415/6444517-daniel-kaneman-dumay-medlenno-reshay-bystro.jpg")
                div(class="absolute-bottom title-book text-subtitle2\n") Семь навыков высокоэффективных людей
              q-card-section(class="text-caption")
                | Во-первых, эта книга излагает системный подход к определению жизненных целей, приоритетов человека. Эти цели у всех разные, но книга помогает понять себя и четко сформулиров....
            q-card(class="card")
              q-img(src="https://cv5.litres.ru/pub/c/elektronnaya-kniga/cover_415/9361857-ha-dzhun-chang-kak-ustroena-ekonomika.jpg")
                div(class="absolute-bottom title-book text-subtitle2\n") Семь навыков высокоэффективных людей
              q-card-section(class="text-caption")
                | Во-первых, эта книга излагает системный подход к определению жизненных целей, приоритетов человека. Эти цели у всех разные, но книга помогает понять себя и четко сформулиров....

          q-toolbar(class="bg-grey-3")
            q-toolbar-title(align="middle") Лучшие книги

</template>

<script>
  export default {
    data() {
      return {
        slide: 1
      }
    }
  }
      // error: {}
</script>

<style>
  .slider {
    text-align: right;
    padding: 24px;
    color: white;
    background-color: rgba(0, 0, 0, .3)
  }
  .title-book {
    text-align: center;
    padding: 12px;
    color: white;
    background-color: rgba(0, 0, 0, .3)
  }
  .card {
    width: 100%;
    max-width: 200px;
    height: 100%;
    max-height: 400px;
  }
</style>