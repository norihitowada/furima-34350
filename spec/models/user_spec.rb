require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameが１文字以上で登録できる' do
        @user.nickname = 'a'
        expect(@user).to be_valid
      end
      it '@を含むemailは登録できる' do
        @user.email = 'a@a'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが一致していて。６文字以上の半角英数字混合であれば登録できる' do
        @user.password = '11111a'
        @user.password_confirmation = '11111a'
        expect(@user).to be_valid
      end
      it 'name_kanji_lastが全角（漢字、ひらがな、カタカナ）であれば登録できる' do
        @user.name_kanji_last = '佐藤さとうサトウ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'name_kanji_firstが全角（漢字、ひらがな、カタカナ）であれば登録できる' do
        @user.name_kanji_first = '佐藤さとうサトウ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'name_kanji_lastが全角（カタカナ）であれば登録できる' do
        @user.name_kanji_last = 'タロウ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'name_kanji_firstが全角（カタカナ）であれば登録できる' do
        @user.name_kanji_first = 'タロウ'
        @user.valid?
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailがある場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it '@を含まないemailは登録できない' do
        @user.email = 'aaaaaaaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが全角英数混合では登録できない' do
        @user.password = 'ＡＡＡＡＡ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが５文字以下の半角英字では登録できない' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが５文字以下の半角英数字混合では登録できない' do
        @user.password = '1111a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが6文字以上、半角数字だけでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが6文字以上、半角英字だけでは登録できない' do
        @user.password = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが異なっていれば登録できない' do
        @user.password = '11111a'
        @user.password_confirmation = '11111b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'name_kanji_lastが空では登録できない' do
        @user.name_kanji_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji last can't be blank")
      end
      it 'name_kanji_lastが半角英字では登録できない' do
        @user.name_kanji_last = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kanji last 全角文字を使用してください')
      end
      it 'name_kanji_lastが半角数字では登録できない' do
        @user.name_kanji_last = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kanji last 全角文字を使用してください')
      end
      it 'name_kanji_lastが半角英数字混合では登録できない' do
        @user.name_kanji_last = '1a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kanji last 全角文字を使用してください')
      end
      it 'name_kanji_firstが空では登録できない' do
        @user.name_kanji_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kanji first 全角文字を使用してください')
      end
      it 'name_kanji_firstが半角では登録できない' do
        @user.name_kanji_first = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kanji first 全角文字を使用してください')
      end
      it 'name_kanji_firstが半角数字では登録できない' do
        @user.name_kanji_first = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kanji first 全角文字を使用してください')
      end
      it 'name_kanji_firstが半角英数字混合では登録できない' do
        @user.name_kanji_first = '1a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kanji first 全角文字を使用してください')
      end
      it 'name_kana_lastが空では登録できない' do
        @user.name_kana_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana last can't be blank")
      end
      it 'name_kana_lastが半角では登録できない' do
        @user.name_kana_last = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last カタカナを使用してください')
      end
      it 'name_kana_lastが半角数字では登録できない' do
        @user.name_kana_last = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last カタカナを使用してください')
      end
      it 'name_kanji_lastが半角英数字混合では登録できない' do
        @user.name_kana_last = '1a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last カタカナを使用してください')
      end
      it 'name_kana_lastが全角（漢字）であれば登録できない' do
        @user.name_kana_last = '佐藤'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last カタカナを使用してください')
      end
      it 'name_kana_lastが全角（ひらがな）であれば登録できない' do
        @user.name_kana_last = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last カタカナを使用してください')
      end
      it 'name_kana_lastが全角（漢字、ひらがな）であれば登録できない' do
        @user.name_kana_last = '佐藤さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last カタカナを使用してください')
      end
      it 'name_kana_lastが半角、全角（漢字、ひらがな）であれば登録できない' do
        @user.name_kana_last = '1a佐藤さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last カタカナを使用してください')
      end
      it 'name_kana_firstが空では登録できない' do
        @user.name_kana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana first can't be blank")
      end
      it 'name_kana_firstが半角では登録できない' do
        @user.name_kana_first = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana first カタカナを使用してください')
      end
      it 'name_kana_firstが半角数字では登録できない' do
        @user.name_kana_first = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana first カタカナを使用してください')
      end
      it 'name_kanji_firstが半角英数字混合では登録できない' do
        @user.name_kana_first = '1a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana first カタカナを使用してください')
      end
      it 'name_kana_firstが全角（漢字）であれば登録できない' do
        @user.name_kana_first = '佐藤'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana first カタカナを使用してください')
      end
      it 'name_kana_firstが全角（ひらがな）であれば登録できない' do
        @user.name_kana_first = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana first カタカナを使用してください')
      end
      it 'name_kana_firstが全角（漢字、ひらがな）であれば登録できない' do
        @user.name_kana_first = '佐藤さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana first カタカナを使用してください')
      end
      it 'name_kana_firstが半角、全角（漢字、ひらがな）であれば登録できない' do
        @user.name_kana_first = '1a佐藤さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana first カタカナを使用してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
