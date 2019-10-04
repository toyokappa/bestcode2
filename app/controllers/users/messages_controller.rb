class Users::MessagesController < Users::ApplicationController
  before_action :find_message_user
  before_action :verify_messagable_user
  before_action :list_messages

  def index
    @message = current_user.sent_messages.build

    # 既読処理
    received_messages = @messages.where(receiver: current_user)
    received_messages.update_all(is_already_read: true) unless received_messages.all?(:is_already_read?)
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    @message.receiver = @message_user
    if @message.save
      redirect_to users_messages_path(@message_user.name), success: "メッセージを送信しました"
    else
      render :index
    end
  end

  def destroy
    deletable_messages = @messages.where(sender: current_user)
    deletable_messages.find(params[:id]).destroy!
    redirect_to users_messages_path(@message_user.name), success: "メッセージを削除しました"
  end

  private

    def message_params
      params.require(:message).permit(:body)
    end

    def find_message_user
      @message_user = User.find_by!(name: params[:user_name])
    end

    def list_messages
      @messages = Message.exchange_between(current_user, @message_user).order(created_at: :desc).includes(:sender)
    end

    def verify_messagable_user
      redirect_to users_message_box_path if @message_user == current_user
    end
end
