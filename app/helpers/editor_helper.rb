module EditorHelper
  def require_text
    <<-EOF
      def require(file)
        root_object = MrubyJs.get_root_object
        session = root_object.sessions[file]
        code = session.call('getValue')
        eval(code)
      end
    EOF
  end
end
