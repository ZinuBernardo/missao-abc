# 📦 Missão ABC — Lista Completa de Assets Necessários

> Este documento lista **TODOS** os arquivos de áudio e imagem que o aplicativo precisa para funcionar corretamente.
> Nenhum arquivo de áudio existe ainda. Algumas imagens já foram criadas.

---

## 📊 RESUMO GERAL

| Tipo | Total Necessário | Já Existe | Faltam |
|---|---|---|---|
| 🔊 Áudios — Efeitos | 3 | 0 | **3** |
| 🔊 Áudios — Letras | 16 | 0 | **16** |
| 🔊 Áudios — Sílabas | 10 | 0 | **10** |
| 🔊 Áudios — Palavras | 6 | 0 | **6** |
| 🔊 Áudios — Histórias | 5 | 0 | **5** |
| 🖼️ Imagens — Palavras | 7 | 5 | **2** |
| 🖼️ Imagens — Figurinhas | 6 | 3 | **3** |
| **TOTAL** | **53** | **8** | **45** |

---

## 🔊 ÁUDIOS — EFEITOS SONOROS (3 arquivos)

**Pasta de destino:** `assets/audio/effects/`

Estes são sons curtos (1-2 segundos) usados como feedback nas interações.

| # | Nome do Arquivo | O que é | Como conseguir |
|---|---|---|---|
| 1 | `correct.mp3` | Som de acerto. Ex: "ding!" alegre, sino, harpa curta | Pixabay: pesquisar "correct answer sound" ou "success chime" |
| 2 | `wrong.mp3` | Som de erro. Ex: "boing", buzina suave, "womp womp" | Pixabay: pesquisar "wrong answer" ou "error buzzer" |
| 3 | `pop.mp3` | Som de clique/toque. Ex: bolha estourando, "pop" suave | Pixabay: pesquisar "pop sound" ou "bubble pop" |

### 🌐 Sites para baixar efeitos sonoros gratuitos:
- **https://pixabay.com/sound-effects/** — Sem cadastro, sem direitos autorais
- **https://mixkit.co/free-sound-effects/** — Alta qualidade, grátis
- **https://freesound.org/** — Comunidade enorme (requer cadastro gratuito)

### ⚠️ Dicas:
- O som deve ter no máximo **1-2 segundos** de duração
- Prefira sons **leves e alegres** (é um app para crianças!)
- Formato: **MP3** (o app usa a biblioteca `audioplayers`)
- Evite sons assustadores ou muito altos para o som de erro

---

## 🔊 ÁUDIOS — PRONÚNCIA DAS LETRAS (16 arquivos)

**Pasta de destino:** `assets/audio/letters/`

Cada arquivo é uma gravação curta da pronúncia da letra em português brasileiro.

| # | Nome do Arquivo | Texto a ser falado | Duração ideal |
|---|---|---|---|
| 4 | `a.mp3` | "Aaa" (som da vogal A) | ~1 seg |
| 5 | `b.mp3` | "Bê" | ~1 seg |
| 6 | `c.mp3` | "Cê" | ~1 seg |
| 7 | `d.mp3` | "Dê" | ~1 seg |
| 8 | `e.mp3` | "É" (som da vogal E) | ~1 seg |
| 9 | `f.mp3` | "Éfe" | ~1 seg |
| 10 | `g.mp3` | "Gê" | ~1 seg |
| 11 | `h.mp3` | "Agá" | ~1 seg |
| 12 | `i.mp3` | "Iii" (som da vogal I) | ~1 seg |
| 13 | `l.mp3` | "Éle" | ~1 seg |
| 14 | `m.mp3` | "Éme" | ~1 seg |
| 15 | `o.mp3` | "Ó" (som da vogal O) | ~1 seg |
| 16 | `p.mp3` | "Pê" | ~1 seg |
| 17 | `s.mp3` | "Ésse" | ~1 seg |
| 18 | `t.mp3` | "Tê" | ~1 seg |
| 19 | `u.mp3` | "Uuu" (som da vogal U) | ~1 seg |

### 🎤 Como criar estes áudios:

#### OPÇÃO A — TTSMaker (mais rápido, 100% gratuito)
1. Acesse **https://ttsmaker.com/**
2. No campo de texto, digite a pronúncia (ex: "Aaa")
3. Em **Language**, selecione **Portuguese (Brazil)**
4. Escolha uma voz feminina suave (ex: "Francisca" ou "Camila")
5. Clique em **Convert to Speech**
6. Clique em **Download** e salve como `a.mp3`
7. Repita para cada letra

#### OPÇÃO B — Gravar você mesmo (mais natural)
1. Use o gravador de voz do celular
2. Fale com voz **clara, alegre e pausada** (como se falasse com uma criança)
3. Grave em ambiente **silencioso**
4. Corte o silêncio extra no início e no fim (use o app gratuito "Audacity" no PC)
5. Exporte como `.mp3` com qualidade 128kbps

---

## 🔊 ÁUDIOS — PRONÚNCIA DAS SÍLABAS (10 arquivos)

**Pasta de destino:** `assets/audio/syllables/`

Cada arquivo é a pronúncia isolada de uma sílaba em português.

| # | Nome do Arquivo | Texto a ser falado | Usado em |
|---|---|---|---|
| 20 | `bo.mp3` | "Bô" | Montagem: BOLO, BOLA |
| 21 | `lo.mp3` | "Lô" | Montagem: BOLO |
| 22 | `la.mp3` | "Lá" | Montagem: BOLA |
| 23 | `ga.mp3` | "Gá" | Montagem: GATO |
| 24 | `to.mp3` | "Tô" | Montagem: GATO (também é distrator) |
| 25 | `sa.mp3` | "Sá" | Montagem: SAPO, MESA |
| 26 | `po.mp3` | "Pô" | Montagem: SAPO |
| 27 | `me.mp3` | "Mê" | Montagem: MESA |
| 28 | `ma.mp3` | "Má" | Distrator na fase de sílabas |
| 29 | `pa.mp3` | "Pá" | Distrator na fase de sílabas |

### 🎤 Como criar:
- Use o mesmo método das letras (TTSMaker ou gravação manual)
- No TTSMaker, digite apenas a sílaba isolada: "Bô", "Lô", etc.
- Duração ideal: **0.5 a 1 segundo**

---

## 🔊 ÁUDIOS — PRONÚNCIA DAS PALAVRAS (6 arquivos)

**Pasta de destino:** `assets/audio/words/`

Cada arquivo é a pronúncia completa e clara de uma palavra.

| # | Nome do Arquivo | Texto a ser falado | Usado em |
|---|---|---|---|
| 30 | `bolo.mp3` | "Bolo" | Fase 2 (Sílabas) |
| 31 | `bola.mp3` | "Bola" | Fase 2 (Sílabas) + Fase 3 (Leitura) |
| 32 | `gato.mp3` | "Gato" | Fase 2 (Sílabas) + Fase 3 (Leitura) |
| 33 | `sapo.mp3` | "Sapo" | Fase 2 (Sílabas) |
| 34 | `mesa.mp3` | "Mesa" | Fase 2 (Sílabas) |
| 35 | `maca.mp3` | "Maçã" | Fase 3 (Leitura) |

### 🎤 Como criar:
- TTSMaker: digite a palavra e baixe
- Duração ideal: **1 segundo**

---

## 🔊 ÁUDIOS — NARRAÇÃO DAS HISTÓRIAS (5 arquivos)

**Pasta de destino:** `assets/audio/stories/`

Cada arquivo é a narração de uma frase completa da história, lida de forma **lenta, expressiva e amigável**.

| # | Nome do Arquivo | Frase a ser narrada | História |
|---|---|---|---|
| 36 | `story1_p1.mp3` | "O Gato vê a bola." | O Gato e a Bola (pág. 1) |
| 37 | `story1_p2.mp3` | "A bola é azul." | O Gato e a Bola (pág. 2) |
| 38 | `story1_p3.mp3` | "O Gato pula na bola!" | O Gato e a Bola (pág. 3) |
| 39 | `sun.mp3` | "O Sol brilha de dia." | O Sol e a Lua (pág. 1) |
| 40 | `moon.mp3` | "A Lua brilha de noite." | O Sol e a Lua (pág. 2) |

### 🎤 Como criar:
- **TTSMaker é ideal aqui!** Cole a frase inteira e gere
- Escolha a voz mais **suave e expressiva** disponível
- Velocidade: levemente mais **lenta** que o normal (crianças precisam de mais tempo)
- Duração ideal: **2-4 segundos** por frase

---

## 🖼️ IMAGENS QUE FALTAM (5 arquivos)

### Palavras (2 imagens)

**Pasta de destino:** `assets/images/words/`

| # | Nome do Arquivo | Conteúdo da imagem | Estilo recomendado |
|---|---|---|---|
| 41 | `frog.png` | Um sapo verde simpático | Cartoon infantil, colorido, fundo transparente |
| 42 | `table.png` | Uma mesa simples | Cartoon infantil, colorido, fundo transparente |

### Figurinhas do Álbum (3 imagens)

**Pasta de destino:** `assets/images/stickers/`

| # | Nome do Arquivo | Conteúdo da imagem | Estilo recomendado |
|---|---|---|---|
| 43 | `giraffe.png` | Uma girafa alta e sorridente | Cartoon infantil, estilo "fofo", fundo transparente |
| 44 | `monkey.png` | Um macaco curioso e brincalhão | Cartoon infantil, estilo "fofo", fundo transparente |
| 45 | `alligator.png` | Um jacaré dorminhoco e amigável | Cartoon infantil, estilo "fofo", fundo transparente |

### 🌐 Sites para baixar imagens gratuitas:
- **https://www.flaticon.com/** — Ícones e ilustrações infantis (grátis com atribuição)
- **https://www.freepik.com/** — Ilustrações de alta qualidade
- **https://undraw.co/** — Ilustrações SVG editáveis
- **https://www.vecteezy.com/** — Vetores gratuitos

### ⚠️ Requisitos das imagens:
- Formato: **PNG** com fundo **transparente**
- Tamanho mínimo: **512x512 pixels**
- Estilo: **cartoon infantil**, cores **vibrantes e alegres**
- Sem textos na imagem

---

## ✅ CHECKLIST DE CRIAÇÃO RÁPIDA

### Passo 1: Efeitos Sonoros (~5 minutos)
- [ ] Baixar `correct.mp3` do Pixabay
- [ ] Baixar `wrong.mp3` do Pixabay
- [ ] Baixar `pop.mp3` do Pixabay
- [ ] Colocar na pasta `assets/audio/effects/`

### Passo 2: Letras (~15 minutos)
- [ ] Abrir o TTSMaker (https://ttsmaker.com/)
- [ ] Selecionar idioma: Portuguese (Brazil)
- [ ] Gerar e baixar cada letra: a, b, c, d, e, f, g, h, i, l, m, o, p, s, t, u
- [ ] Colocar na pasta `assets/audio/letters/`

### Passo 3: Sílabas (~10 minutos)
- [ ] No TTSMaker, gerar: bo, lo, la, ga, to, sa, po, me, ma, pa
- [ ] Colocar na pasta `assets/audio/syllables/`

### Passo 4: Palavras (~5 minutos)
- [ ] No TTSMaker, gerar: bolo, bola, gato, sapo, mesa, maçã
- [ ] Colocar na pasta `assets/audio/words/`

### Passo 5: Histórias Narradas (~5 minutos)
- [ ] No TTSMaker, gerar cada frase:
  - "O Gato vê a bola." → `story1_p1.mp3`
  - "A bola é azul." → `story1_p2.mp3`
  - "O Gato pula na bola!" → `story1_p3.mp3`
  - "O Sol brilha de dia." → `sun.mp3`
  - "A Lua brilha de noite." → `moon.mp3`
- [ ] Colocar na pasta `assets/audio/stories/`

### Passo 6: Imagens (~10 minutos)
- [ ] Baixar/criar `frog.png` e `table.png`
- [ ] Colocar na pasta `assets/images/words/`
- [ ] Baixar/criar `giraffe.png`, `monkey.png` e `alligator.png`
- [ ] Colocar na pasta `assets/images/stickers/`

---

## ⏱️ TEMPO TOTAL ESTIMADO: ~50 minutos

> **Dica:** O mais rápido é usar o TTSMaker para todos os áudios de pronúncia/narração
> e o Pixabay para os 3 efeitos sonoros. Leva cerca de 40-50 minutos no total.

---

## 🗂️ ESTRUTURA FINAL DAS PASTAS

Após adicionar todos os arquivos, suas pastas devem ficar assim:

```
assets/
├── audio/
│   ├── effects/
│   │   ├── correct.mp3      ← #1
│   │   ├── wrong.mp3        ← #2
│   │   └── pop.mp3          ← #3
│   ├── letters/
│   │   ├── a.mp3            ← #4
│   │   ├── b.mp3            ← #5
│   │   ├── c.mp3            ← #6
│   │   ├── d.mp3            ← #7
│   │   ├── e.mp3            ← #8
│   │   ├── f.mp3            ← #9
│   │   ├── g.mp3            ← #10
│   │   ├── h.mp3            ← #11
│   │   ├── i.mp3            ← #12
│   │   ├── l.mp3            ← #13
│   │   ├── m.mp3            ← #14
│   │   ├── o.mp3            ← #15
│   │   ├── p.mp3            ← #16
│   │   ├── s.mp3            ← #17
│   │   ├── t.mp3            ← #18
│   │   └── u.mp3            ← #19
│   ├── syllables/
│   │   ├── bo.mp3           ← #20
│   │   ├── lo.mp3           ← #21
│   │   ├── la.mp3           ← #22
│   │   ├── ga.mp3           ← #23
│   │   ├── to.mp3           ← #24
│   │   ├── sa.mp3           ← #25
│   │   ├── po.mp3           ← #26
│   │   ├── me.mp3           ← #27
│   │   ├── ma.mp3           ← #28
│   │   └── pa.mp3           ← #29
│   ├── words/
│   │   ├── bolo.mp3         ← #30
│   │   ├── bola.mp3         ← #31
│   │   ├── gato.mp3         ← #32
│   │   ├── sapo.mp3         ← #33
│   │   ├── mesa.mp3         ← #34
│   │   └── maca.mp3         ← #35
│   └── stories/
│       ├── story1_p1.mp3    ← #36
│       ├── story1_p2.mp3    ← #37
│       ├── story1_p3.mp3    ← #38
│       ├── sun.mp3          ← #39
│       └── moon.mp3         ← #40
├── images/
│   ├── app_icon.png         ✅ existe
│   ├── words/
│   │   ├── apple.png        ✅ existe
│   │   ├── ball.png         ✅ existe
│   │   ├── cake.png         ✅ existe
│   │   ├── cat.png          ✅ existe
│   │   ├── frog.png         ← #41
│   │   └── table.png        ← #42
│   ├── stickers/
│   │   ├── lion.png         ✅ existe
│   │   ├── zebra.png        ✅ existe
│   │   ├── elephant.png     ✅ existe
│   │   ├── giraffe.png      ← #43
│   │   ├── monkey.png       ← #44
│   │   └── alligator.png    ← #45
│   └── stories/
│       ├── cat_ball_cover   ✅ existe
│       ├── page1.png        ✅ existe
│       ├── page2.png        ✅ existe
│       ├── page3.png        ✅ existe
│       ├── sun.png          ✅ existe
│       ├── moon.png         ✅ existe
│       └── sun_moon_cover   ✅ existe
└── fonts/
```

---

**Após adicionar todos os assets, o app estará 100% funcional!** 🚀
