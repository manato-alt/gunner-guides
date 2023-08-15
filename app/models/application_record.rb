# frozen_string_literal: true

# ApplicationRecordはActiveRecordのベースクラスで、データベーステーブルとの対話を容易にする機能を提供します。
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
