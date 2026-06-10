shader_type canvas_item;

uniform int frames = 4; // liczba klatek w poziomie
uniform float speed = 5.0; // klatki na sekundę

void fragment() {
    vec2 uv = UV;
    // Obliczanie aktualnej klatki na podstawie czasu
    float frame = floor(mod(TIME * speed, float(frames)));
    // Przesunięcie UV do odpowiedniej klatki
    uv.x = (uv.x + frame) / float(frames);
    COLOR = texture(TEXTURE, uv);
}