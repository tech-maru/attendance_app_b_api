[勤怠システムB]

※Userモデルのバリデーション
1 ユーザー名:存在性の有無、最大文字数５０文字
2 メールアドレス：存在性の有無、パターン制限、最大文字数１００文字、一意性
3 パスワード：存在性の有無、８文字以上かつ２０文字以下、大文字小文字記号を含む制限
4 確認用パスワードの要求

※Attendanceモデルのバリデーション
仕様書通り
但し、テスト仕様書９項及び２１項の
「退社時間もしくは出社時間のみの更新ができないこと」に関しては、
趣旨を考慮して、
「前日以前の勤怠情報に関しては、退社をブランクとする更新はできない」
というバリデーションを加えた。
《理由》
本日に関しては、出勤時間を間違えたということもありうるので、
退勤時間を入力してからでないと出勤時間の更新ができないのは不便だと考えた為。

《追加機能》
最後の１５分切り捨ての実装について。
勤怠表示ページのみの実装とし、更新ページでは、
切り捨て前の時間を確認できるようにした。

《テスト仕様》
管理者権限ボタン、一般ユーザボタン作成