module EditorHelper
  def require_text
    <<-EOF
      def require(file)
        root_object = MrubyJs.get_root_object
        session_name = file + '.rb'
        session = root_object.sessions[session_name]
        code = session.call('getValue')
        root_object.interpretCode(code)
      end
    EOF
  end
end
