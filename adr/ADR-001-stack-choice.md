# ADR-001: Escolha do Flutter e Firebase

**Status:** Accepted
**Data:** 2026-02-24

**Contexto:**
O projeto "Missão ABC" requer um desenvolvimento rápido para Android e iOS, com alta fidelidade visual (gamificação) e suporte offline robusto para crianças que podem não ter conexão constante. Além disso, a segurança dos dados infantis e a escalabilidade para múltiplos países são essenciais.

**Decisão:**
Utilizar **Flutter** como framework de frontend e **Firebase** (Backend-as-a-Service).

**Justificativa:**
1. **Flutter:** Permite 60fps/120fps constantes, essencial para animações fluidas em jogos pedagógicos. Código compartilhado entre Android e iOS reduz custos e tempo de lançamento (Time-to-Market).
2. **Firebase:**
   - **Firestore:** Oferece sincronização offline nativa, perfeita para o uso infantil.
   - **Auth:** Fornece autenticação segura e fácil de implementar para os pais.
   - **Cloud Functions:** Permite executar lógica de backend segura sem gerenciar servidores (Serverless).
   - **Analytics/Crashlytics:** Essencial para monitorar o uso e falhas em tempo real.

**Consequências:**
- Dependência (Vendor Lock-in) com o ecossistema Google Firebase.
- Custos escalonáveis conforme o uso (Pay-as-you-go), exigindo monitoramento de faturamento.
- Necessidade de desenvolvedores com conhecimento em Dart.
