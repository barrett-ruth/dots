return {
    s('{%', fmt('{{% {} %}}', { i(1) })),
    s('block', fmt('{{% block {} %}}\n{}\n{{% endblock %}}', { i(1), i(2) })),
}
