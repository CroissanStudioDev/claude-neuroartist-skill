<p align="center">
  <h1 align="center">🎨 neuroartist skill</h1>
  <p align="center">
    AI-скилл для генерации изображений, видео и аудио через единый API
    <br />
    <a href="https://skill.neuroartist.ru/docs"><strong>Документация »</strong></a>
    <br />
    <br />
    <a href="https://skill.neuroartist.ru/dashboard">Получить API-ключ</a>
    ·
    <a href="https://github.com/CroissanStudioDev/neuroartist-skill-agents/issues">Сообщить о баге</a>
    ·
    <a href="https://github.com/CroissanStudioDev/neuroartist-skill-agents/issues">Предложить фичу</a>
  </p>
</p>

<p align="center">
  <a href="https://github.com/CroissanStudioDev/neuroartist-skill-agents/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/license-GPL--3.0-blue.svg" alt="License">
  </a>
  <a href="https://github.com/CroissanStudioDev/neuroartist-skill-agents/releases">
    <img src="https://img.shields.io/badge/version-1.5.0-green.svg" alt="Version">
  </a>
  <a href="https://skill.neuroartist.ru">
    <img src="https://img.shields.io/badge/models-1195+-purple.svg" alt="Models">
  </a>
</p>

---

## Что это?

**neuroartist** — это скилл (плагин) для AI-агентов, который даёт им возможность генерировать контент: изображения, видео, векторную графику и аудио.

**Почему скилл, а не просто API?**

| Обычный API | neuroartist Skill |
|-------------|-------------------|
| Агент сам выбирает модель | Скилл знает какую модель для чего |
| Агент сам пишет промпт | Скилл адаптирует под контекст |
| Документация на 100 страниц | Компактные схемы (~300 токенов) |
| Результат на заблокированном CDN | Российский CDN, работает везде |

---

## Содержание

- [Быстрый старт](#быстрый-старт)
- [Установка](#установка)
  - [Claude Code](#claude-code)
  - [OpenCode](#opencode)
  - [Cursor](#cursor)
  - [Windsurf](#windsurf)
  - [OpenClaw](#openclaw)
- [Специализированные скиллы](#специализированные-скиллы)
- [Использование](#использование)
- [Модели](#модели)
- [Размеры для платформ](#размеры-для-платформ)
- [Структура файлов](#структура-файлов)
- [Лицензия](#лицензия)

---

## Быстрый старт

### 1. Установка

```bash
curl -sSL https://raw.githubusercontent.com/CroissanStudioDev/neuroartist-skill-agents/main/install.sh | bash
```

Скрипт покажет найденные агенты. Для установки укажите нужные:

```bash
# Установить для всех найденных агентов
curl -sSL ... | bash -s -- all

# Установить для конкретного агента
curl -sSL ... | bash -s -- claude

# Установить для нескольких агентов
curl -sSL ... | bash -s -- claude cursor opencode
```

### 2. Получите API-ключ

Зарегистрируйтесь на [skill.neuroartist.ru](https://skill.neuroartist.ru) и создайте ключ в разделе [Dashboard → Tokens](https://skill.neuroartist.ru/dashboard/tokens).

### 3. Попросите агента сгенерировать

```
Сгенерируй изображение заката над горами для поста в VK
```

Скилл автоматически:
- Выберет оптимальную модель (FLUX Schnell для быстрого результата)
- Применит правильный размер (1080×1080 для VK)
- Вернёт ссылку на готовое изображение

---

## Установка

### Поддерживаемые платформы

| Платформа | Статус | Метод установки |
|-----------|--------|-----------------|
| Claude Code | ✅ Плагин | Plugin system / git clone |
| OpenCode | ✅ Совместим | git clone |
| Cursor | ✅ Совместим | git clone |
| Windsurf | ✅ Совместим | git clone |
| OpenClaw | ✅ CLI | `openclaw skills install` |

### Claude Code

**Через систему плагинов (рекомендуется):**

```bash
# 1. Добавить маркетплейс (один раз)
/plugin marketplace add CroissanStudioDev/neuroartist-skill-agents

# 2. Установить плагин
/plugin install neuroartist@CroissanStudioDev-neuroartist-skill-agents
```

**Ручная установка:**

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.claude/plugins/neuroartist
```

### OpenCode

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.opencode/skills/neuroartist
```

### Cursor

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.cursor/skills/neuroartist
```

### Windsurf

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.windsurf/skills/neuroartist
```

### OpenClaw

**Через CLI (рекомендуется):**

```bash
openclaw skills install github:CroissanStudioDev/neuroartist-skill-agents
# или короче
claw install github:CroissanStudioDev/neuroartist-skill-agents
```

**Ручная установка:**

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.openclaw/skills/neuroartist
```

### Обновление

Скрипт установки автоматически обновляет существующие установки:

```bash
curl -sSL https://raw.githubusercontent.com/CroissanStudioDev/neuroartist-skill-agents/main/install.sh | bash -s -- all
```

---

## Специализированные скиллы

Помимо основного скилла `neuroartist`, доступны фокусированные версии для конкретных задач:

| Скилл | Фокус | Когда использовать |
|-------|-------|-------------------|
| `neuroartist` | Всё | Универсальный — изображения, видео, аудио |
| `neuroartist-image` | Изображения | Только генерация картинок, апскейл, удаление фона |
| `neuroartist-video` | Видео | Только text-to-video, image-to-video |
| `neuroartist-audio` | Аудио | Только TTS, STT, клонирование голоса |

### Зачем нужны специализированные скиллы?

**Экономия токенов.** Основной скилл загружает документацию по всем типам контента (~300 токенов). Специализированный загружает только релевантную (~150 токенов).

**Точнее триггеры.** Если вы работаете только с аудио, используйте `neuroartist-audio` — он не будет активироваться на "generate image".

### Установка специализированных скиллов

Специализированные скиллы находятся в `skills/neuroartist/skills/`:

```bash
# Структура
skills/neuroartist/
├── SKILL.md                    # Основной (универсальный)
└── skills/
    ├── neuroartist-image/      # Только изображения
    │   └── SKILL.md
    ├── neuroartist-video/      # Только видео
    │   └── SKILL.md
    └── neuroartist-audio/      # Только аудио
        └── SKILL.md
```

При стандартной установке все скиллы доступны автоматически.

### Триггеры специализированных скиллов

**neuroartist-image:**
```
generate image, create image, flux, nano banana, recraft, upscale,
remove background, text to image, сгенерируй картинку, убери фон
```

**neuroartist-video:**
```
generate video, create video, kling, minimax, luma, hunyuan,
text to video, image to video, сгенерируй видео, анимируй
```

**neuroartist-audio:**
```
text to speech, tts, speech to text, stt, transcribe, whisper,
voice cloning, озвучь, транскрибируй, голос
```

---

## Использование

### Триггеры активации

Скилл автоматически активируется на фразы:

| Категория | Триггеры |
|-----------|----------|
| Изображения | `generate image`, `create image`, `сгенерируй картинку` |
| Видео | `generate video`, `create video`, `сгенерируй видео` |
| Аудио | `text to speech`, `tts`, `озвучь`, `transcribe`, `транскрибируй` |
| Модели | `flux`, `nano banana`, `recraft`, `kling`, `stable diffusion` |
| Обработка | `upscale`, `remove background`, `убери фон` |
| Платформы | `для вк`, `для телеграм`, `для инстаграм` |

### API Reference

**Базовый URL:** `https://skill.neuroartist.ru/api/v1`

**Авторизация:**
```
Authorization: Bearer na_live_xxx
```

**Генерация (POST /generate):**

```bash
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer na_live_xxx" \
  -H "Content-Type: application/json" \
  -d '{
    "m": "fal-ai/flux/schnell",
    "i": {
      "prompt": "sunset over mountains",
      "image_size": "landscape_16_9"
    },
    "s": true
  }'
```

| Поле | Тип | Описание |
|------|-----|----------|
| `m` | string | ID модели (обязательно) |
| `i` | object | Параметры (зависят от модели) |
| `s` | boolean | Синхронный режим (true = ждать результат) |

**Ответ:**

```json
{
  "id": "req_abc123",
  "url": "https://cdn.neuroartist.ru/result.jpg",
  "ms": 2100
}
```

**Размеры изображений:**

```
square        1024×1024    square_hd      1536×1536
portrait_4_3  768×1024     portrait_16_9  576×1024
landscape_4_3 1024×768     landscape_16_9 1024×576
```

### CLI-скрипты

Скрипты для быстрой автоматизации в `scripts/`:

```bash
# Настройка и проверка ключа
export NEUROARTIST_KEY=na_live_xxx
./scripts/setup.sh

# Поиск моделей
./scripts/search.sh image    # Изображения
./scripts/search.sh video    # Видео
./scripts/search.sh audio    # Аудио (TTS/STT)
./scripts/search.sh flux     # Семейство FLUX

# Быстрая генерация
./scripts/generate.sh "закат над горами"
./scripts/generate.sh "портрет кота" fal-ai/flux/dev portrait_4_3

# Обработка изображений
./scripts/upscale.sh https://example.com/photo.jpg          # Апскейл 4x
./scripts/rembg.sh https://example.com/product.jpg          # Удаление фона

# Аудио
./scripts/tts.sh "Привет, это тест"                         # Озвучка
./scripts/stt.sh https://example.com/recording.mp3          # Транскрипция

# Проверка баланса
./scripts/balance.sh
```

---

## Модели

### Быстрый выбор

| Задача | Модель | Скорость | Стоимость |
|--------|--------|----------|-----------|
| Быстрый драфт | `fal-ai/flux/schnell` | 2 сек | ~0.3₽ |
| Качественное фото | `fal-ai/flux/dev` | 10 сек | ~1.4₽ |
| Текст на изображении | `fal-ai/nano-banana-pro` | 8 сек | ~13₽ |
| Векторная графика (SVG) | `fal-ai/recraft/v4/text-to-vector` | 5 сек | ~7₽ |
| Видео | `fal-ai/kling-video/v2.5/turbo/text-to-video` | 45 сек | ~50₽ |
| Озвучка (TTS) | `fal-ai/f5-tts` | 3 сек | ~2₽ |
| Транскрипция (STT) | `fal-ai/whisper` | 5 сек | ~1₽ |
| Апскейл 4x | `fal-ai/aura-sr` | 3 сек | ~2₽ |
| Удаление фона | `fal-ai/birefnet` | 2 сек | ~1₽ |

### Гайд по выбору

```
Нужен текст/инфографика?  →  Nano Banana Pro
Нужен вектор (SVG)?       →  Recraft V4 Text-to-Vector
Логотип/иконки?           →  Recraft V4 Vector
Быстрый драфт?            →  FLUX Schnell
Качественное фото?        →  FLUX Pro или Nano Banana Pro
Дизайн для маркетинга?    →  Recraft V4
Видео с контролем?        →  Kling 2.5/3.0
Видео быстро?             →  MiniMax или Luma
Озвучка/клонирование?     →  F5-TTS
Транскрипция аудио?       →  Whisper
```

### Семейства моделей

**Nano Banana (Google Gemini)** — лучший для текста и инфографики
- 94% точность текста (vs 60% у FLUX)
- До 14 референсов в одном запросе
- Консистентность персонажей
- Нативное 4K разрешение

**FLUX (Black Forest Labs)** — универсальный выбор
- Schnell: быстрые итерации (2 сек)
- Dev: финальные изображения (10 сек)
- Pro: профессиональное качество (15 сек)

**Recraft V4** — профессиональный дизайн
- Нативный SVG (настоящие пути, не трейсинг)
- Контроль палитры (точные RGB цвета)
- Готово для Figma/Illustrator

**Kling (Kuaishou)** — видео с контролем
- v2.5 Turbo: 5 сек видео за 45 сек
- v3.0: 4K/60fps, 15 сек, мульти-шот, диалоги

Полный список в [references/models.md](skills/neuroartist/references/models.md)

---

## Размеры для платформ

### ВКонтакте

| Формат | Размер | image_size |
|--------|--------|------------|
| Пост | 1080×1080 | `square` |
| История | 1080×1920 | `portrait_16_9` (или custom) |
| Обложка | 1920×768 | custom |

### Telegram

| Формат | Размер | image_size |
|--------|--------|------------|
| Стикер | 512×512 | `square` |
| Аватар канала | 640×640 | `square` |
| Превью ссылки | 1280×640 | `landscape_16_9` |

### Instagram

| Формат | Размер | image_size |
|--------|--------|------------|
| Пост (квадрат) | 1080×1080 | `square` |
| Пост (портрет) | 1080×1350 | `portrait_4_3` |
| Stories/Reels | 1080×1920 | `portrait_16_9` |

### YouTube

| Формат | Размер | image_size |
|--------|--------|------------|
| Превью | 1280×720 | `landscape_16_9` |
| Shorts | 1080×1920 | `portrait_16_9` |

Полный список в [references/platforms.md](skills/neuroartist/references/platforms.md)

---

## Структура файлов

```
neuroartist-skill-agents/
├── install.sh                      # Универсальный установщик
├── LICENSE                         # GPL-3.0
├── README.md                       # Этот файл
│
├── .claude-plugin/
│   ├── plugin.json                 # Манифест плагина
│   └── marketplace.json            # Метаданные для маркетплейса
│
└── skills/
    └── neuroartist/
        ├── SKILL.md                # Главный файл скилла (всегда загружается)
        │
        ├── scripts/                # CLI-скрипты для автоматизации
        │   ├── setup.sh            # Проверка ключа и баланса
        │   ├── search.sh           # Поиск моделей по категориям
        │   ├── generate.sh         # Быстрая генерация
        │   └── balance.sh          # Проверка баланса
        │
        ├── skills/                 # Специализированные скиллы
        │   ├── neuroartist-image/  # Только изображения (FLUX, Nano Banana, Recraft)
        │   │   └── SKILL.md
        │   ├── neuroartist-video/  # Только видео (Kling, MiniMax, Luma)
        │   │   └── SKILL.md
        │   └── neuroartist-audio/  # Только аудио (TTS, STT, клонирование)
        │       └── SKILL.md
        │
        ├── references/             # Справочники (загружаются по требованию)
        │   ├── models.md           # Полный каталог моделей
        │   ├── platforms.md        # Размеры для соцсетей
        │   ├── prompting-images.md # Гайд по промптам для Nano Banana
        │   └── prompting-video.md  # Гайд по промптам для Kling
        │
        └── examples/
            └── workflows.md        # Примеры цепочек генераций
```

### Token-оптимизация

| Файл | Токенов | Когда загружается |
|------|---------|-------------------|
| SKILL.md (основной) | ~300 | Всегда |
| neuroartist-image/SKILL.md | ~150 | Только для изображений |
| neuroartist-video/SKILL.md | ~200 | Только для видео |
| neuroartist-audio/SKILL.md | ~150 | Только для аудио |
| models.md | ~700 | При выборе модели |
| platforms.md | ~200 | При указании платформы |
| prompting-images.md | ~500 | При работе с Nano Banana |
| prompting-video.md | ~600 | При работе с Kling |

**Типичное использование:**
- Основной скилл: ~800-1200 токенов (база + 1-2 справочника)
- Специализированный: ~400-600 токенов (фокус на одном типе)

---

## Contributing

Мы приветствуем вклад в проект!

1. Форкните репозиторий
2. Создайте ветку для фичи (`git checkout -b feature/amazing-feature`)
3. Закоммитьте изменения (`git commit -m 'Add amazing feature'`)
4. Запушьте ветку (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

### Что можно улучшить

- [ ] Добавить новые модели в каталог
- [ ] Расширить гайды по промптам
- [ ] Добавить примеры для новых use-кейсов
- [ ] Перевести документацию на другие языки
- [ ] Добавить поддержку новых AI-агентов

---

## Лицензия

Распространяется под лицензией **GPL-3.0**. Это значит:

- ✅ Можно использовать в любых проектах
- ✅ Можно модифицировать
- ✅ Можно распространять
- ⚠️ Производные работы должны оставаться открытыми под GPL-3.0

Подробности в файле [LICENSE](LICENSE).

---

## Ссылки

- 🌐 **Сайт:** [skill.neuroartist.ru](https://skill.neuroartist.ru)
- 📖 **Документация:** [skill.neuroartist.ru/docs](https://skill.neuroartist.ru/docs)
- 🔑 **Dashboard:** [skill.neuroartist.ru/dashboard](https://skill.neuroartist.ru/dashboard)
- 🐛 **Issues:** [GitHub Issues](https://github.com/CroissanStudioDev/neuroartist-skill-agents/issues)

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/CroissanStudioDev">Croissan Studio</a>
</p>
