# 同じ128件の再評価（手動contract witness）

**実agentのrolloutではない。** 数値は同じ固定ケースについて、特定の規則解釈が許す／誘導する行動を追跡した記録。`fixed`は当該assertionの修正であり実運用の成功率ではない。`still-ambiguous`は既知の未修正問題も含む。未知のownerはunknownのまま。

| ID | request | before gate / q | after gate / q | 判定 | 変更後根拠・残存不確実性 |
|---|---|---|---|---|---|
| C001 | ヘッダーを16pxにして | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C002 | この余白を16pxにしていい感じに揃えて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C003 | SaveをDoneに変えて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C004 | この関数だけ、挙動を変えず読みやすくして | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C005 | p95を200ms以下にして | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C006 | このメールをもっと温かくして。添付の承認済み例と同じ調子で | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C007 | 新しいLPをモダンにして。仕様Aと既存tokensどおりに作って | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C008 | この既存LPをモダンにして。承認済み画面Aに余白だけ揃えて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C009 | 前の案、なんか違う。見出しだけ元の文言に戻して | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C010 | ここをちゃんと実装して。空配列なら200と[]を返すだけ | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C011 | このSVGをきれいにして。小数を2桁に丸め、形は維持 | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C012 | この商品名を簡潔にして。候補は「灯」に決めた | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C013 | 弔電を穏やかに整えて。宗教表現なし、80字以内、私が最終確認する | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C014 | このスライドを見やすく。本文24pt以上、指定グリッドへ揃えるだけ | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C015 | この案内をブランドらしく。添付voice guideの禁止語だけ除いて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C016 | フォームを使いやすく。labelとinputをidで関連付けて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C017 | Make the header spacing nice: set only padding-top to 16px. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C018 | Clean this up using the checked-in formatter, no semantic changes. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C019 | Do it properly: return 409 for duplicate keys and keep the existing error schema. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C020 | Make this faster by removing the duplicate fetch; keep output identical. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C021 | Make the copy warmer, matching approved sample B, without changing the offer. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C022 | Refactor this function only: extract repeated validation, preserve the signature. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C023 | Make this image better by cropping to 1:1 around the marked product. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C024 | Polish these slides by aligning titles to x=40, without changing content. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C025 | Modernize all 80 files using the exact approved codemod. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C026 | Clean up these three files by deleting a.tmp, b.tmp, c.tmp. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C027 | Make the onboarding easier: remove only the optional survey step. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C028 | Not quite it: replace the orange accent with token brand.primary. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C029 | Make this name friendlier: use “Team inbox” exactly. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C030 | Rewrite this to sound warmer; retain all facts and I will judge the tone. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C031 | よしなに直して | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C032 | 適当にやって | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C033 | make the header spacing nice | closed / 0 | open / 1 | fixed | P1の条件付きGATEとP3/P4により、指定済みの部分は聞かず未決のmaterial decisionだけを扱う。 |
| C034 | make the header spacing nice | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C035 | この余白いい感じにして | closed / 0 | open / 1 | fixed | P1の条件付きGATEとP3/P4により、指定済みの部分は聞かず未決のmaterial decisionだけを扱う。 |
| C036 | いい感じにして | closed / 0 | open / 1 | fixed | P1の条件付きGATEとP3/P4により、指定済みの部分は聞かず未決のmaterial decisionだけを扱う。 |
| C037 | ここリファクタして | open / 1 | open / 1 | fixed | P4: optionは本物のまま、根拠がないrecommended Aだけを除く。 |
| C038 | このAPIちゃんと実装して | closed / 0 | open / 1 | fixed | P1の条件付きGATEとP3/P4により、指定済みの部分は聞かず未決のmaterial decisionだけを扱う。 |
| C039 | 一覧は6行にして | closed / 0 | open / 1 | fixed | P1の条件付きGATEとP3/P4により、指定済みの部分は聞かず未決のmaterial decisionだけを扱う。 |
| C040 | なんか違う | closed / 0 | open / 1 | fixed | P1の条件付きGATEとP3/P4により、指定済みの部分は聞かず未決のmaterial decisionだけを扱う。 |
| C041 | このブランドっぽくして | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C042 | 余白をきれいに揃えて | closed / 0 | closed / 0 | fixed | P2: baselineとdesired-state authorityを分離。適用するnorm/current correctionに沿い0問。 |
| C043 | エラー処理をちゃんと揃えて | closed / 0 | closed / 0 | fixed | P2: baselineとdesired-state authorityを分離。適用するnorm/current correctionに沿い0問。 |
| C044 | この計算をちゃんと直して | closed / 0 | closed / 0 | fixed | P2: baselineとdesired-state authorityを分離。適用するnorm/current correctionに沿い0問。 |
| C045 | このメールをうちらしくして | closed / 0 | closed / 0 | still-ambiguous | 固定oracleは例外の有無を聞くopenを要求するが、現行guideをbindingと読めばformalへ0問も妥当。oracleを変えずstill-ambiguousとして残す。 |
| C046 | 前の案、もっと落ち着いた文面にして | closed / 0 | closed / 0 | fixed | P2: baselineとdesired-state authorityを分離。適用するnorm/current correctionに沿い0問。 |
| C047 | Make the service names consistent. | closed / 0 | open / 1 | fixed | P2: 同時に適用される規約の衝突を、読み順で解決済みとしない。 |
| C048 | 好きに決めて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C049 | 新しいLPをモダンにして | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C050 | 新しいお礼メールを温かく書いて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C051 | 新規のお知らせをちゃんと書いて | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C052 | Create a new settings screen that feels modern. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C053 | 通知設定の新画面を使いやすくして | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C054 | Implement this new API properly. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C055 | 新しい配送APIをちゃんと作って | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C056 | 新しいジョブ名、いい感じに決めて | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C057 | この概念をいい感じの名前にして | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C058 | 既存の画面をモダンにして | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。アクセス取得まで依存する実作業は引き続き止まる。blocker消滅ではなく必要なaccess-requestへの置換。 |
| C059 | この画面を仕様どおりモダンに作り直して | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C060 | 削除した前のLPを、いい感じに作り直して | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C061 | Write a new condolence note, warm but not sentimental. | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C062 | 新規ブランド紹介、温かくお願い | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C063 | 新しいイラストをいい感じに | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C064 | 新しい発表資料をすっきり作って | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C065 | Create a fresh error message that sounds human. | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C066 | 新しい販売案内をうまく書いて | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C067 | 新規CLIのhelpをちゃんと作って | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C068 | 新しい注意書きを整えて | open / 0 | open / 1 | fixed | P2で不存在をblockerにしない。実際に不足するfieldだけP3/P4で聞く。候補生成費用など別assertionの遵守を証明するものではない。 |
| C069 | どの顧客向けかはまだ言ってないけど文面作って | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C070 | 顧客に送るからいい感じに整えて | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C071 | この請求書の法人名をちゃんと入れて | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C072 | このメール、いい感じにして送って | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C073 | 古い顧客データを整理して消して | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C074 | この3ファイル削除して整理して | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C075 | この声明を正式に公開して | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C076 | このファイル、最新版で上書きして | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C077 | 契約条項をいい感じに直して提出して | open / 1 | open / 1 | fixed | P4: optionは本物のまま、根拠がないrecommended Aだけを除く。 |
| C078 | 公開日をちゃんと入れてリリース告知を公開して | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C079 | Add the correct purchase-order number to this draft. | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C080 | Fix the exchange-rate assumption properly. | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C081 | Write the offer with the right price. | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C082 | このボタン、正しい顧客名にして | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C083 | この警告、適切な数値にして | closed / 0 | open / 1 | fixed | P3/P4: 小さくても未知の事実・参照は未決。必要な1フィールドだけをnarrowに取得。 |
| C084 | 適当に宛名を入れて送って | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C085 | 好きに決めて、今の顧客データを消して | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C086 | この採用オファーを仕上げて | open / 1 | open / 4 | fixed | P3: 必須4フィールドを3+1で扱う。新forkでない既知の未決も2round目の対象。0問目標のためのdefault化は禁止。 |
| C087 | このDMを送る時刻、先方の都合に合わせて | open / 0 | open / 1 | fixed | P3/P4: 宛先・対象・事実の特定と、特定済み最終操作の承認を分離。 |
| C088 | この匿名化をちゃんとやって | open / 1 | open / 1 | fixed | P4: 未知の保管先はfieldを狭く直接聞く。架空の保管先menuを作らない。 |
| C089 | もう、よしなにして | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C090 | その二択、意味が分からない | open / 0 | open / 0 | fixed | P3: explicit decline/delegation以外を委任に変換しない。2round後は説明・再ground・依存作業保留。 |
| C091 | 日本語で説明して。よく分からない | open / 0 | open / 0 | fixed | P3: explicit decline/delegation以外を委任に変換しない。2round後は説明・再ground・依存作業保留。 |
| C092 | どっちも違う、もっと静かな感じ | open / 0 | open / 0 | fixed | P3: explicit decline/delegation以外を委任に変換しない。2round後は説明・再ground・依存作業保留。 |
| C093 | まだ迷ってる。違いを説明してほしい | open / 0 | open / 0 | fixed | P3: explicit decline/delegation以外を委任に変換しない。2round後は説明・再ground・依存作業保留。 |
| C094 | 本文はBで | open / 0 | open / 0 | fixed | P3: explicit decline/delegation以外を委任に変換しない。2round後は説明・再ground・依存作業保留。 |
| C095 | いい感じに揃えて | open / 0 | open / 0 | fixed | P5: 可逆local workをapproval不要で進めるが、観測されていないassentを記録しない。 |
| C096 | その内容で送信してよいです | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C097 | 雰囲気は任せます | closed / 0 | closed / 0 | unchanged-correct | 外向き操作の明示承認は元から必要だった。新しい安全性を創作せず負例controlとして維持。 |
| C098 | この発表文を温かくして、そのまま公開して | open / 0 | open / 0 | unchanged-correct | 外向き操作の明示承認は元から必要だった。新しい安全性を創作せず負例controlとして維持。 |
| C099 | make it nice | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Description/trigger competes with the supplied owner stub dialogue or diagnosis; possible duplicate clarification, not an observed runtime selection. |
| C100 | clean this up | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Description/trigger competes with the supplied owner stub dialogue or diagnosis; possible duplicate clarification, not an observed runtime selection. |
| C101 | do it properly | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Description/trigger competes with the supplied owner stub dialogue or diagnosis; possible duplicate clarification, not an observed runtime selection. |
| C102 | not quite it | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Description/trigger competes with the supplied owner stub dialogue or diagnosis; possible duplicate clarification, not an observed runtime selection. |
| C103 | refactor this | unknown / None | unknown / None | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Actual installed owner contract not available; cannot judge routing. |
| C104 | make this faster | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Translation row mandates measurement and relative target before identifying the business metric; user-only objective may be invented and measurement may block. |
| C105 | whatever you think | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C106 | make this easier to use | closed / 0 | open / 1 | fixed | P1の条件付きGATEとP3/P4により、指定済みの部分は聞かず未決のmaterial decisionだけを扱う。 |
| C107 | write this feature | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C108 | review this design | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C109 | plan this feature | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Description/trigger competes with the supplied owner stub dialogue or diagnosis; possible duplicate clarification, not an observed runtime selection. |
| C110 | plan this properly | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C111 | make this test suite more reliable | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Description/trigger competes with the supplied owner stub dialogue or diagnosis; possible duplicate clarification, not an observed runtime selection. |
| C112 | make this image better | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Description/trigger competes with the supplied owner stub dialogue or diagnosis; possible duplicate clarification, not an observed runtime selection. |
| C113 | rewrite this to sound warmer | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C114 | この機能を計画して | closed / 0 | closed / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Route-elsewhere names an absent skill without specifying the fallback; witness stalls rather than performing normal planning. |
| C115 | make it faster | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Translation row mandates measurement and relative target before identifying the business metric; user-only objective may be invented and measurement may block. |
| C116 | もっと速くして | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Translation row mandates measurement and relative target before identifying the business metric; user-only objective may be invented and measurement may block. |
| C117 | この処理の待ち時間を減らして | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Translation row mandates measurement and relative target before identifying the business metric; user-only objective may be invented and measurement may block. |
| C118 | この一覧の初回表示を速くして | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Translation row mandates measurement and relative target before identifying the business metric; user-only objective may be invented and measurement may block. |
| C119 | 全500ファイルをいい感じに整形して | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C120 | この画面をいい感じに | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Never ask repo-readable information lacks a discovery-cost limit; witness continues costly search instead of asking a locator. |
| C121 | このサービスの設定をちゃんと揃えて | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Never ask repo-readable information lacks a discovery-cost limit; witness continues costly search instead of asking a locator. |
| C122 | ロゴの雰囲気、いい感じにして | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Cheapness/ownership and accounting of prototype construction remain unspecified; side effects or cost can be hidden outside clarification cost. |
| C123 | Make this page feel more premium. | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Cheapness/ownership and accounting of prototype construction remain unspecified; side effects or cost can be hidden outside clarification cost. |
| C124 | この文章、もう少し温かい感じに | closed / 0 | closed / 0 | unchanged-correct | ケースが指定するdecision assertionは元から正しい。gate-shut表示のnoise等、未行使の規則まで正しいという意味ではない。 |
| C125 | 保存方式はまだ迷ってるけど、進められる所は進めて | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Technically independent tests/docs can lock in an unresolved architecture; synchronous while-waiting instruction lacks an operational meaning. |
| C126 | この小さなキャプションを優しく | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Mandatory Not doing manufactures a non-goal for a fully bounded tiny edit; subjective tone cannot be settled by a trivial character-count test. |
| C127 | make it nice | open / 0 | open / 0 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Literal-copy reading preserves make it nice rather than its grounded observable meaning; prohibition on paraphrase conflicts with restating intent. |
| C128 | このUI、温かいけど感傷的でない感じに | open / 1 | open / 1 | still-ambiguous | 未修正の規則によるwitness/不確実性を維持。Third-party runnable wording can reopen an already specified requester preference acceptance; mechanical success is not subjective approval. |
