require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  let(:task) { FactoryBot.create(:task ,name: 'メイラーspecを書く', description: '送信したメールの内容を確認します') }
  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
    part.body.raw_source
  end

  describe '#creation_email' do
    let(:mail) { TaskMailer.creation_mail(task) }

    it 'ヘッダにおいて想定通りのメールが生成されている' do
      expect(mail.subject).to eq 'タスク作成完了メール'
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['taskleaf@example.com'])
    end

    it 'text形式において想定通りのメールが生成されている' do
      expect(text_body).to match '以下のタスクを作成しました'
      expect(text_body).to match 'メイラーspecを書く'
      expect(text_body).to match '送信したメールの内容を確認します'
    end

    it 'html形式において想定通りのメールが生成されている' do
      expect(html_body).to match '以下のタスクを作成しました'
      expect(html_body).to match 'メイラーspecを書く'
      expect(html_body).to match '送信したメールの内容を確認します'
    end
  end
end
