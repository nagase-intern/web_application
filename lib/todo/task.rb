# coding: utf-8

require 'active_record'

module Todo

  class Task < ActiveRecord::Base
    scope :status_is, ->(status) { where(status: status) }#ステータスによる一覧取得

    scope :status_is_not_yet, -> { status_is(NOT_YET) }
    scope :status_is_done, -> { status_is(DONE) }
    scope :status_is_pending, -> { status_is(PENDING) }

    NOT_YET = 0 #タスク未完了
    DONE = 1    #タスク完了
    PENDING =2  #保留中のタスク

    STATUS ={
      'NOT_YET' => NOT_YET,
      'DONE' => DONE,
      'PENDING' => PENDING
    }.freeze

    #値のチェック
    validates :name,    presence:     true, length: {maximum: 140}
    validates :content, presence:     true
    validates :status,  numericality: true, inclusion: {in: STATUS.values}

    def status_name
      STATUS.key(self.status)
    end
  end
end